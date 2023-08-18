require("custom")

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = "**/nvim/*.lua",
    callback = function()
        local fp = vim.fn.expand('%:p')
        if string.find(fp, "nvim/init.lua") ~= nil then return end
        vim.schedule(function()
            vim.cmd("so")
        end)
    end
})
