require("custom")
require("colorScheme")

ColorMyPencils()

vim.schedule(ColorMyPencils)
local nvim_bufnr = vim.api.nvim_get_current_buf()

local startBufSize = vim.api.nvim_buf_get_name(nvim_bufnr)

if startBufSize == '' then
    vim.api.nvim_buf_delete(nvim_bufnr, { force = true })
    require('startup').display()
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, {

    group = vim.api.nvim_create_augroup("colorSchemeGroup", { clear = true }),
    callback = function()
        local match = vim.fn.expand('<amatch>')
        ColorMyPencils(match)
        local file = assert(io.open(os.getenv("HOME") .. [[/configs/nvim/lua/colorScheme.lua]], 'w+'))
        if file == nil then
            file = assert(io.open(os.getenv("HOME") .. [[/configs/nvim/lua/colorScheme.lua]], 'w+'))
        end

        if file == nil then
            vim.print('No file')
            return ""
        end
        file:write('SelectedColorScheme = "' .. match .. '"')
        file:close()
    end
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = vim.api.nvim_create_augroup("writePreGroup", { clear = true }),
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {

    group = vim.api.nvim_create_augroup("writePostGroup", { clear = true }),
    pattern = "**/nvim/*.lua",
    callback = function()
        local fp = vim.fn.expand('%:p')
        if string.find(fp, "nvim/init.lua") ~= nil then return end
        vim.schedule(function()
            print("sourced file: " .. vim.fn.expand('%:t'))
            vim.cmd("so")
        end)
    end
})
