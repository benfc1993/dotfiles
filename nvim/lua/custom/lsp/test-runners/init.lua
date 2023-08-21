local M = {}

local attached_lang = nil

local languages = {
    java = require("custom.lsp.java.test-runner")
}

M.attach = function(language)
    if attached_lang == language then return end
    attached_lang = language

    local runner_group = vim.api.nvim_create_augroup('testRunnerGroup', { clear = true })

    vim.api.nvim_create_user_command('AutoRun', function()
        languages[language].create_watcher(runner_group)
    end, {})


    vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
        group = runner_group,
        pattern = languages[language].pattern,
        callback = function()
            local bufnr = tonumber(vim.fn.expand('<abuf>')) or -1
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            languages[language].render_test_marks(buf_name)
        end
    })
end

return M
