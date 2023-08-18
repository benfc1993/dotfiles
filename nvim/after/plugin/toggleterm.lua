local t = 0

local toggle_terms = function()
    if t == 0 then t = 1 end
    if t > 1 then
        vim.cmd('ToggleTermToggleAll')
    else
        vim.cmd('ToggleTerm')
    end
end

vim.keymap.set('n', '<C-\\>', toggle_terms, {})

local create_new_term = function()
    t = t + 1
    if t == 1 then
        vim.cmd('ToggleTerm')
    else
        vim.api.nvim_input('<esc>')
        vim.cmd(t .. 'ToggleTerm')
        vim.api.nvim_input('i')
    end
end

vim.keymap.set({ 'n', 't' }, '<M-\\>', create_new_term, {})

require("toggleterm").setup({
    on_open = function(terminal)
        if terminal.__state.mode == 'n' then
            vim.api.nvim_input('i')
        end
    end,
    on_exit = function(terminal)
        print("Hello: " .. terminal.id)
    end
})

local function set_terminal_mappings()
    local opts = {}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-\\>', '<cmd>ToggleTermToggleAll<CR>', opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = [[term://*]],
    callback = set_terminal_mappings
})
