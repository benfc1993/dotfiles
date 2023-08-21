local M = {}

M.pattern = '*.java'

local ns = vim.api.nvim_create_namespace('javaTest')

local test_function_query_string = [[
(
(method_declaration name: (identifier) @name)

(#eq? @name "%s")
)
]]

local tests = {}
local renderedBufs = {}

local find_buffer_by_name = function(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:find(name, 0, true) ~= nil then
            return buf
        end
    end
    return -1
end


local find_test_line = function(bufnr, name)
    local formatted = string.format(test_function_query_string, name)
    local query = vim.treesitter.query.parse("java", formatted)
    local parser = vim.treesitter.get_parser(bufnr, "java", {})
    local tree = parser:parse()[1]
    local root = tree:root()

    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        if id == 1 then
            local range = { node:range() }
            return range[1]
        end
    end
end


local add_test = function(test_line, status, reason)
    local file, method
    local i = 0
    for w in string.gmatch(test_line, "%S+") do
        if i == 0 then
            file = w:gsub('%.', '/'):match(".+/(.*)[%.]?.*$")
        elseif i == 2 then
            method = w:gsub('%A', '')
        end
        i = i + 1
    end

    tests[file] = {
        status = status,
        file = "java/" .. file .. ".java",
        method = method,
        reason = reason
    }
end

local parse_output = function(data)
    if not data then return end
    local valid_lines = {}
    local testInfoReached = false
    for _, line in pairs(data) do
        if testInfoReached then
            testInfoReached = line:find('actionable tasks') == nil
            if testInfoReached and line ~= "" then
                table.insert(valid_lines, line)
            end
        else
            testInfoReached = line:match('> Task :app:test%A+') or line:match('> Task :app:test$')
        end
    end
    local held_line = nil
    local description_lines = {}

    local function try_add_fail_test()
        if held_line ~= nil then
            add_test(held_line, 'failed', description_lines)
        end
        held_line = nil
    end

    for _, validLine in pairs(valid_lines) do
        if validLine:find("PASSED") then
            add_test(validLine, 'passed')
            try_add_fail_test()
        elseif validLine:find("SKIPPED") then
            add_test(validLine, 'skipped')
            try_add_fail_test()
        elseif validLine:find("FAILED") then
            try_add_fail_test()
            held_line = validLine
        elseif held_line ~= nil and validLine ~= '' then
            local trimed_line = validLine:gsub('^%s*(.-)%s*$', '%1')
            table.insert(description_lines, trimed_line)
        end
    end
    try_add_fail_test()
end

local clear_marks = function(bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    vim.diagnostic.reset(ns, bufnr)
end

M.render_test_marks = function(file_path)
    local file_name = file_path:match(".+/(.*)[%.]+.*$")
    local bufnr = find_buffer_by_name(file_name)

    if bufnr == -1 then return end
    clear_marks(bufnr)
    table.insert(renderedBufs, bufnr)
    local test = tests[file_name]
    if not test then return end

    local failed = {}

    local line = find_test_line(bufnr, test.method)

    if test.status ~= 'failed' then
        local text = { test.status == 'passed' and "✓" or "⊘" }
        vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text } })
    else
        local text = { "✗" }
        vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text } })
        local message = test.reason and table.concat(test.reason, ',') or "Test failed"

        table.insert(failed, {
            bufnr = bufnr,
            lnum = line,
            col = 0,
            severity = vim.diagnostic.severity.ERROR,
            source = "java-test",
            message = message,
            user_data = {},
        })
    end
    vim.diagnostic.set(ns, bufnr, failed, {})
end

M.create_watcher = function(runner_group)
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = runner_group,
        pattern = "*.java",
        callback = function()
            tests = {}
            vim.fn.jobstart({ './gradlew', 'test' }, {
                stdout_buffered = true,
                on_stdout = function(_, data) parse_output(data) end,
                on_stderr = function(_, data) parse_output(data) end,
                on_exit = function()
                    for _, bufnr in pairs(renderedBufs) do
                        clear_marks(bufnr)
                    end
                    for _, test in pairs(tests) do
                        M.render_test_marks(test.file)
                    end
                end
            })
        end
    })
end

return M
