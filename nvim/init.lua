require("custom")

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("MyGroup", { clear = true }),
    pattern = "PackerComplete",
    callback = function()
        ColorMyPencils()
        vim.cmd('q')
    end
})
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
