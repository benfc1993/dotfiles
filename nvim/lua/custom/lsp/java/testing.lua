local M = {}

local ns = vim.api.nvim_create_namespace('javaTest')

local test_function_query_string = [[
(
(method_declaration name: (identifier) @name)

(#eq? @name "%s")
)
]]

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


local add_test = function(test_line, status, tests_table, reason)
    local file, method
    local i = 0
    for w in string.gmatch(test_line, "%S+") do
        if i == 0 then
            file = w:gsub('%.', '/')
        elseif i == 2 then
            method = w
        end
        i = i + 1
    end

    local bufnr = find_buffer_by_name(file)

    local line = bufnr == -1 and -1 or find_test_line(bufnr, method)


    table.insert(tests_table, {
        status = status,
        bufnr = bufnr,
        line = line,
        file = "src/test/java/" .. file .. '.java',
        method = method,
        reason = reason
    })
end

local parse_output = function(data, tests)
    if not data then return end
    local valid_lines = {}
    local testInfoReached = false
    for _, line in pairs(data) do
        if testInfoReached then
            testInfoReached = line:find('actionable tasks') == nil
            if testInfoReached then
                table.insert(valid_lines, line)
            end
        else
            testInfoReached = line:match('> Task :app:test%A?')
        end
    end

    local held_line = nil
    local description_lines = {}

    local function try_add_fail_test()
        if held_line ~= nil then
            add_test(held_line, 'failed', tests, description_lines)
        end
        held_line = nil
    end

    for _, validLine in pairs(valid_lines) do
        if validLine:find("PASSED") then
            add_test(validLine, 'passed', tests)
            try_add_fail_test()
        elseif validLine:find("SKIPPED") then
            add_test(validLine, 'skipped', tests)
            try_add_fail_test()
        elseif validLine:find("FAILED") then
            try_add_fail_test()
            held_line = validLine
        elseif held_line ~= nil and validLine ~= '' then
            local trimed_line = validLine:gsub('^%s*(.-)%s*$', '%1')
            table.insert(description_lines, trimed_line)
        end
    end
end

local create_watcher = function()
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('javaWatcher', { clear = true }),
        pattern = "*.java",
        callback = function()
            local tests = {}
            vim.fn.jobstart({ 'gradle', 'test' }, {
                stdout_buffered = true,
                on_stdout = function(_, data) parse_output(data, tests) end,
                on_stderr = function(_, data) parse_output(data, tests) end,
                on_exit = function()
                    local failed = {}
                    for _, test in pairs(tests) do
                        if test.bufnr == -1 or test.line == -1 then
                            goto continue
                        end
                        vim.api.nvim_buf_clear_namespace(test.bufnr, ns, 0, -1)
                        if test.status ~= 'failed' then
                            local text = { test.status == 'passed' and "✓" or "⊘" }
                            vim.api.nvim_buf_set_extmark(test.bufnr, ns, test.line, 0, { virt_text = { text } })
                        else
                            local text = { "✗" }
                            vim.api.nvim_buf_set_extmark(test.bufnr, ns, test.line, 0, { virt_text = { text } })
                            local message = test.reason and table.concat(test.reason, ',') or "Test failed"
                            table.insert(failed, {
                                bufnr = test.bufnr,
                                lnum = test.line,
                                col = 0,
                                severity = vim.diagnostic.severity.ERROR,
                                source = "go-test",
                                message = message,
                                user_data = {},
                            })
                        end
                        vim.diagnostic.set(ns, test.bufnr, failed, {})
                        ::continue::
                    end
                end
            })
        end
    })
end

M.setup = function()
    vim.api.nvim_create_user_command('AutoRun', function()
        create_watcher()
    end, {})
end

return M
