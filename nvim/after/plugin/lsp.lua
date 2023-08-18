local lsp = require('lsp-zero').preset({
    manage_nvim_cmp = {
        set_extra_mappings = true,
    }
})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr, remap = false }

    for k, v in pairs(client.config.filetypes)
    do
        if v == "java" then
            vim.keymap.set('n', '<leader>t', Create_class_test)
            break
        end
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "d]", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", [[<C-_>]], function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

lsp.buffer_autoformat()
-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({ 'tsserver', 'eslint' })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({
    --     reason = cmp.ContextReason.Auto,
    -- }), { "i", "c" })
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
