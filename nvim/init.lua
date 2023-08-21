require("custom")
require("colorScheme")

ColorMyPencils()
vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("PackerGroup", { clear = true }),
    pattern = "PackerComplete",
    callback = function()
        vim.schedule(ColorMyPencils)
        local packer_bufnr = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_list_bufs()[1] then
            vim.api.nvim_create_buf(false, true)
        end
        vim.api.nvim_buf_delete(packer_bufnr, { force = true })
    end
})


vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("colorSchemeGroup", { clear = true }),
    callback = function()
        local match = vim.fn.expand('<amatch>')
        ColorMyPencils(match)
        local file = io.open('lua/colorScheme.lua', 'w+')
        if file == nil then
            file = io.open('lua/colorScheme.lua', 'w')
        end

        if file == nil then return "" end
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
