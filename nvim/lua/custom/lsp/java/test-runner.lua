local M = {}

M.pattern = '*.java'

local ns = vim.api.nvim_create_namespace('javaTest')

local test_function_query_string = [[
(
(method_declaration name: (identifier) @name)

(#eq? @name "%s")
)
]]

local test_marker_query_string = [[(
(method_declaration
    (modifiers
    (marker_annotation name: (identifier) @name)
    )
    (identifier) @method_name
    ) @method
(#eq? @name "%s")
)]]

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
            file = w:find('%A+') and w:gsub('%.', '/'):match(".+/(.*)[%.]?.*$") or w
        elseif i == 2 then
            method = w:gsub('%A', '')
        end
        i = i + 1
    end



    if not tests[file] then tests[file] = {} end
    tests[file][method] = {
        status = status,
        file = file,
        method = method,
        reason = reason
    }
end

local parse_output = function(data)
    print(vim.inspect(data))
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

local clear_marks = function(bufnr, line)
    local linestart = line or 0
    local lineend = line or -1
    vim.api.nvim_buf_clear_namespace(bufnr, ns, linestart, lineend)
    vim.diagnostic.reset(ns, bufnr)
end

M.render_test_marks = function(file_name)
    file_name = file_name:find('%A+') and file_name:match(".+/(.*)[%.]+.*$") or file_name
    local bufnr = find_buffer_by_name(file_name)

    if bufnr == -1 then return end
    clear_marks(bufnr)
    local file_tests = tests[file_name]
    local failed = {}
    if not file_tests then return end

    for _, test in pairs(file_tests) do
        local line = find_test_line(bufnr, test.method)

        if test.status ~= 'failed' then
            local text = { test.status == 'passed' and "✓" or "⊘" }
            local color = test.status == 'passed' and 'DiagnosticOk' or 'DiagnosticWarn'
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text }, hl_group = color })
        else
            local text = { "✗" }
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text }, hl_group = 'DiagnosticError' })
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
    end


    vim.diagnostic.set(ns, bufnr, failed, {})
end

M.mark_tests = function(bufnr)
    local formatted = string.format(test_marker_query_string, 'Test')
    local query = vim.treesitter.query.parse("java", formatted)
    local parser = vim.treesitter.get_parser(bufnr, "java", {})
    local tree = parser:parse()[1]
    local root = tree:root()


    for pattern, match in query:iter_matches(root, bufnr, 0, -1) do
        local range, method_name, declaration_line
        for id, node in pairs(match) do
            local capture_name = query.captures[id]
            if capture_name == "method_name" then
                method_name = vim.treesitter.get_node_text(node, bufnr)
                local r = { node:range() }
                declaration_line = r[1]
            elseif capture_name == "method" then
                range = { node:range() }
            end
        end
        if not renderedBufs[bufnr] then renderedBufs[bufnr] = {} end

        renderedBufs[bufnr][method_name] = {
            range = { range[1] + 1, range[3] + 1 },
            declaration_line = declaration_line,
            method_name = method_name
        }
        signs.add_symbol(signs.symbols.flask, declaration_line, 'javaTestSymbols', bufnr)
    end
    vim.print(vim.inspect(renderedBufs))
end

M.run_single_test = function(bufnr, lnum)
    local methods = renderedBufs[bufnr]

    if not methods then return end
    vim.print(vim.inspect(methods))
    local method = nil
    for _, m in pairs(methods) do
        if m.range[1] > lnum or m.range[2] < lnum then goto continue end
        method = m
        ::continue::
    end

    if not method then return end


    clear_marks(bufnr, method.declaration_line)
    local text = { "◉" }
    local color = 'DiagnosticWarn'
    vim.api.nvim_buf_set_extmark(bufnr, ns, method.declaration_line, 0, { virt_text = { text }, hl_group = color })

    local pattern = '*' .. method.method_name
    vim.fn.jobstart({ './gradlew', 'cleanTest', 'test', '--tests', pattern }, {
        stdout_buffered = true,
        on_stdout = function(_, data) parse_output(data) end,
        on_stderr = function(_, data) parse_output(data) end,
        on_exit = function()
            for file, _ in pairs(tests) do
                M.render_test_marks(file)
            end
        end
    })
end

M.create_watcher = function(runner_group)
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = runner_group,
        pattern = "*.java",
        callback = function()
            for bufnr, _ in pairs(renderedBufs) do
                clear_marks(bufnr)
            end

            vim.fn.jobstart({ './gradlew', 'test' }, {
                stdout_buffered = true,
                on_stdout = function(_, data) parse_output(data) end,
                on_stderr = function(_, data) parse_output(data) end,
                on_exit = function()
                    for file, _ in pairs(tests) do
                        M.render_test_marks(file)
                    end
                end
            })
        end
    })
end

return M
