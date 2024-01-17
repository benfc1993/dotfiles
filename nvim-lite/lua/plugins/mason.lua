require("mason").setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup({
    capabilities = capabilities,
})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        asnc = false,
        bufnr = bufnr,
        silent = true,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_key_mappings = function(bufnr)
    local opts = { buffer = bufnr, remap = false }
    nmap("gd", vim.lsp.buf.definition, "", opts)
    nmap("gt", vim.lsp.buf.type_definition, "", opts)
    nmap("K", vim.lsp.buf.hover, "", opts)
    nmap("<leader>vf", vim.diagnostic.open_float, "", opts)
    nmap("<leader>e", vim.diagnostic.goto_next, "", opts)
    nmap("<leader>w", vim.diagnostic.goto_prev, "", opts)
    nmap([[<C-_>]], vim.lsp.buf.code_action, "", opts)
    nmap("<leader>h", vim.lsp.buf.signature_help, "", opts)
    nmap("<F2>", vim.lsp.buf.rename, "", opts)
end

local format_on_save = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

local lsp_config = require("lspconfig")

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = function(client, bufnr)
                lsp_key_mappings(bufnr)
                format_on_save(client, bufnr)
            end,
        })
    end,

    ["tsserver"] = function()
        lsp_config.tsserver.setup({
            on_attach = function(client, bufnr)
                lsp_key_mappings(bufnr)
                format_on_save(client, bufnr)
                nmap(
                    "<C-l>",
                    require("plugins.language-tools.typescript").logRocket,
                    "",
                    { silent = true, buffer = bufnr }
                )
            end,
        })
    end,
    ["lua_ls"] = function()
        lsp_config["lua_ls"].setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globalse = { "vim" },
                    },
                },
            },
            on_attach = function(client, bufnr)
                lsp_key_mappings(bufnr)
                format_on_save(client, bufnr)
            end,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = "LuaJIT",
                            },
                            -- Make the server aware of Neovim runtime files
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    -- "${3rd}/luv/library"
                                    -- "${3rd}/busted/library",
                                },
                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            },
                        },
                    })

                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
            end,
        })
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --	require("rust-tools").setup {}
    -- end
})