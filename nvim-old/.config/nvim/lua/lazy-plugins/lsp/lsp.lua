return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("neodev").setup({})
		local on_attach = require("lazy-plugins.lsp.utils.on_attach").on_attach
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local servers = require("lazy-plugins.lsp.utils.servers")

		local serverConfigs = {
			vtsls = {
				typescript = {
					inlayHints = {
						parameterTypes = { enabled = true },
						parameterNames = { enabled = "all" },
					},
				},
				on_attach = function(client, bufnr)
					nmap(
						"<leader>l",
						require("plugins.language-tools.typescript").logRocket,
						"",
						{ silent = true, buffer = bufnr }
					)
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true)
					end
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
			gdscript = {
				filetypes = { "gdscript" },
			},
			inlay_hints = { enabled = true },
			cssls = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
			clangd = {
				init_options = {
					fallbackFlags = { "-std=c++20" },
				},
			},
		}

		for _, lsp in ipairs(servers) do
			if lsp.lsp == false then
				goto continue
			end

			local config = {}
			local server = lsp.name
			local lspConfig = serverConfigs[server] or {}

			TableMerge(config, { capabilities = capabilities, on_attach = on_attach }, lspConfig)

			lspconfig[server].setup(config)

			::continue::
		end
		-- lspconfig["tsserver"].setup({
		-- 	on_attach = function(client, bufnr)
		-- 		local opts = { buffer = bufnr, remap = false }
		-- 		nmap("K", vim.lsp.buf.hover, "", opts)
		--
		-- 		local disabledCapabilities = {
		-- 			callHierarchyProvider = false,
		-- 			codeActionProvider = false,
		-- 			codeLensProvider = {
		-- 				resolveProvider = false,
		-- 			},
		--
		-- 			completionProvider = false,
		-- 			definitionProvider = false,
		-- 			documentFormattingProvider = false,
		-- 			documentHighlightProvider = false,
		-- 			documentRangeFormattingProvider = false,
		-- 			documentSymbolProvider = false,
		-- 			executeCommandProvider = {
		-- 				commands = {},
		-- 			},
		-- 			foldingRangeProvider = false,
		-- 			implementationProvider = false,
		-- 			inlayHintProvider = false,
		-- 			linkedEditingRangeProvider = false,
		-- 			referencesProvider = false,
		-- 			renameProvider = false,
		-- 			selectionRangeProvider = false,
		-- 			semanticTokensProvider = false,
		-- 			signatureHelpProvider = false,
		-- 			textDocumentSync = {
		-- 				change = 2,
		-- 				openClose = false,
		-- 				save = {
		-- 					includeText = false,
		-- 				},
		-- 				willSave = false,
		-- 				willSaveWaitUntil = false,
		-- 			},
		-- 			typeDefinitionProvider = false,
		-- 			workspace = {
		-- 				fileOperations = {},
		-- 			},
		-- 			workspaceSymbolProvider = false,
		-- 		}
		-- 		for key, value in pairs(disabledCapabilities) do
		-- 			client.server_capabilities[key] = value
		-- 		end
		-- 	end,
		-- })
	end,
}
