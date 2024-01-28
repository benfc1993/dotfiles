return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("neodev").setup({})
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			nmap("gd", vim.lsp.buf.definition, "", opts)
			nmap("gi", vim.lsp.buf.implementation, "", opts)
			nmap("gt", vim.lsp.buf.type_definition, "", opts)
			nmap("K", vim.lsp.buf.hover, "", opts)
			nmap("<leader>vf", vim.diagnostic.open_float, "", opts)
			nmap("<leader>e", vim.diagnostic.goto_next, "", opts)
			nmap("<leader>w", vim.diagnostic.goto_prev, "", opts)
			nmap([[<C-_>]], vim.lsp.buf.code_action, "", opts)
			nmap("<leader>h", vim.lsp.buf.signature_help, "", opts)
			nmap("<F2>", vim.lsp.buf.rename, "", opts)
			nmap("<leader>rr", "<cmd>LspRestart<cr>", "", opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local servers = require("lazy-plugins.lsp.servers")

		local serverConfigs = {
			tsserver = {
				on_attach = function(client, bufnr)
					nmap(
						"<leader>l",
						require("plugins.language-tools.typescript").logRocket,
						"",
						{ silent = true, buffer = bufnr }
					)
					on_attach(client, bufnr)
				end,
			},
			graphql = {

				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			lua_ls = {
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
		}

		for _, lsp in ipairs(servers) do
			local config = {}
			local lspConfig = serverConfigs[lsp] or {}

			TableMerge(config, { capabilities = capabilities, on_attach = on_attach }, lspConfig)

			lspconfig[lsp].setup(config)
		end
	end,
}
