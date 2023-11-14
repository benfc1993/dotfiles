---@diagnostic disable: missing-fields
local lsp = require('lsp-zero').preset({
    manage_nvim_cmp = {
        set_extra_mappings = true,
        set_sources = 'recommended'
    }
})
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr, remap = false }

    for _, v in pairs(client.config.filetypes)
    do
        require("custom.lsp").attach(v)
    end

    local function on_list(options)
        vim.fn.setqflist({}, ' ', options)
        vim.api.nvim_command('cfirst')
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ reuse_win = true, on_list = on_list }) end, opts)
    vim.keymap.set("n", "<leader><CR>", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol('') end, opts)
    vim.keymap.set("n", "<leader>vf", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "d]", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", [[<C-_>]], function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "F2", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- lsp.buffer_autoformat()

require('neodev').setup()

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.tsserver.setup({
    settings = {
        completions = {
            completeFunctionCalls = true
        }
    }

})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end
lsp.setup()

local luasnip = require 'luasnip'
luasnip.config.setup()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
    ['<Space><CR>'] = cmp.mapping.complete(),
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
    },
}

cmp.setup({
    mapping = cmp.mapping.preset.insert(cmp_mappings),
    -- performance = {
    --     max_view_entries = 10
    -- },
    preselect = cmp.PreselectMode.Item,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,preview,noinsert'
    },
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'luasnip',  keyword_length = 2 },
        {
            name = 'buffer',
            entry_filter = function(entry)
                return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
        },
    }),
    view = {
        docs = {
            auto_open = true
        }
    },
    experimental = {
        ghost_text = true
    },
})
