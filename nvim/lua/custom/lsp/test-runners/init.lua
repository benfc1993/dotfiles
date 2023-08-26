local M = {}

local attached_lang = nil

local test_runner = require('custom.lsp.test-runners.utils')

M.attach = function(language)
    local status, language_test_runner = pcall(require, "custom.lsp.test-runners." .. language)
    if not status then return end
    if attached_lang == language then return end
    attached_lang = language
    local runner_group = vim.api.nvim_create_augroup('testRunnerGroup', { clear = true })

    language_test_runner.create_test_runner(runner_group)

    test_runner.mark_tests(vim.api.nvim_get_current_buf())

    nmap('<F6>', test_runner.run_all_tests, '[TR] run all tests')

    nmap('<S-F6>', function()
        local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
        test_runner.run_single_test(vim.api.nvim_get_current_buf(), r)
    end, '[TR] run sing test')

    nmap('<leader>tr', '<cmd>TROutput<CR>', '[TR] show test output')

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
        group = runner_group,
        pattern = language_test_runner.pattern,
        callback = function()
            local bufnr = tonumber(vim.fn.expand('<abuf>')) or -1
            test_runner.mark_tests(bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            test_runner.render_test_marks(buf_name)
        end
    })
end

return M
