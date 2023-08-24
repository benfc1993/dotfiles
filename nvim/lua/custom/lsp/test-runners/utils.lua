local M = {}

local ns = vim.api.nvim_create_namespace('test-runner')

local tests = {}
local renderedBufs = {}
local test_marker_query_string = nil
--- @type fun(method_name: string): string[]
local single_test_command = function(method_name) return { method_name } end
local test_language = ''

--- @type fun(tests: {}, data: {}): {[string]: {status: 'passed' | 'failed' | 'skipped', file: string, method: string, reason: string[]}}
local parse_output = nil

local find_buffer_by_name = function(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:find(name, 0, true) ~= nil then
            return buf
        end
    end
    return -1
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
        local line = renderedBufs[bufnr][test.method].declaration_line

        if test.status ~= 'failed' then
            local color = test.status == 'passed' and 'DiagnosticOk' or 'DiagnosticWarn'
            local text = { test.status == 'passed' and "\u{25A0} PASSED" or "\u{25A0} SKIPPED", color }
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text } })
        else
            local text = { "\u{25A0} FAILED", 'DiagnosticError' }
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, { virt_text = { text } })
            local message = test.reason and table.concat(test.reason, ',') or "Test failed"

            table.insert(failed, {
                bufnr = bufnr,
                lnum = line,
                col = 0,
                severity = vim.diagnostic.severity.ERROR,
                source = test_language .. "-test",
                message = message,
                user_data = {},
            })
        end
    end


    vim.diagnostic.set(ns, bufnr, failed, {})
end

M.mark_tests = function(bufnr)
    local formatted = string.format(test_marker_query_string)
    local query = vim.treesitter.query.parse(test_language, formatted)
    local parser = vim.treesitter.get_parser(bufnr, test_language, {})
    local tree = parser:parse()[1]
    local root = tree:root()


    for _, match in query:iter_matches(root, bufnr, 0, -1) do
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
        signs.add_symbol(signs.symbols.flask, declaration_line + 1, test_language .. 'TestSymbols', bufnr)
    end
end

M.run_single_test = function(bufnr, lnum)
    local methods = renderedBufs[bufnr]

    if not methods then return end

    local method = nil
    for _, m in pairs(methods) do
        if m.range[1] > lnum or m.range[2] < lnum then goto continue end
        method = m
        ::continue::
    end

    if not method then return end


    clear_marks(bufnr, method.declaration_line)
    local text = { "◉", 'DiagnosticWarn' }
    vim.api.nvim_buf_set_extmark(bufnr, ns, method.declaration_line, 0, { virt_text = { text } })

    local command = single_test_command(method.method_name)
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data) parse_output(tests, data) end,
        on_stderr = function(_, data) parse_output(tests, data) end,
        on_exit = function()
            for file, _ in pairs(tests) do
                M.render_test_marks(file)
            end
        end
    })
end

--- create a test runner
--- @param runner_group number
--- @param language string
--- @param pattern string
--- @param parser fun(tests: {}, data: {}): {[string]: {status: 'passed' | 'failed' | 'skipped', file: string, method: string, reason: string[]}}
--- @param test_query string
--- @param test_command string[]
--- @param single_test_cmd fun(method_name: string): string[]
M.create_test_runner = function(runner_group, language, pattern, parser, test_query, test_command, single_test_cmd)
    parse_output = parser
    test_language = language
    single_test_command = single_test_cmd
    test_marker_query_string = test_query

    vim.api.nvim_create_autocmd('BufWritePost', {
        group = runner_group,
        pattern = pattern,
        callback = function()
            for bufnr, renderedBuf in pairs(renderedBufs) do
                clear_marks(bufnr)
                for _, test in pairs(renderedBuf) do
                    local text = { "◉", 'DiagnosticWarn' }
                    vim.api.nvim_buf_set_extmark(bufnr, ns, test.declaration_line, 0, { virt_text = { text } })
                end
            end

            vim.fn.jobstart(test_command, {
                stdout_buffered = true,
                on_stdout = function(_, data) parse_output(tests, data) end,
                on_stderr = function(_, data) parse_output(tests, data) end,
                on_exit = function()
                    for file, fileTests in pairs(tests) do
                        M.render_test_marks(file)
                    end
                end
            })
        end
    })

    vim.api.nvim_create_autocmd('BufUnload', {
        group = runner_group,
        pattern = pattern,
        callback = function()
            local bufnr = vim.fn.expand('<abuf>')
            renderedBufs[bufnr] = nil
        end
    })
end
return M
