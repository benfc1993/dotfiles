require("toggleterm").setup({
    -- open_mapping = [[<C-\>]],
    -- on_create = function()
        -- print("Test")
    -- end,
    -- direction = "horizontal",
    -- winbar = {
        -- enabled = false,
    -- }
})

local function set_terminal_mappings()
    local opts = {}
    vim.keymap.set('t', '<C-\\>', [[<cmd>ToggleTerm<CR>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-n>', function()
        vim.cmd(vim.v.count .. 'ToggleTerm')
    end, opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = [[term://*]],
    callback = set_terminal_mappings
})

local t = 1

vim.keymap.set('n', '<C-\\>', function ()
    vim.cmd(t .. 'ToggleTerm')
    t = t + 1
end, {})



