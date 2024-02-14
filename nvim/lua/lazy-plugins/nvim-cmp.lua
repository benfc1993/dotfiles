return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")
		imap("<C-j>", function()
			luasnip.jump(1)
		end)
		imap("<C-k>", function()
			luasnip.jump(-1)
		end)

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect,noinsert",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<M-u>"] = cmp.mapping.scroll_docs(-4),
				["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
				-- ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<M-d>"] = cmp.mapping.scroll_docs(4),
				["<Space><CR>"] = cmp.mapping.complete({ config = { preselect = "item" } }),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			preselect = "item",
			view = {
				docs = {
					auto_open = true,
				},
			},
			experimental = {
				ghost_text = true,
			},
			confirmation = {
				default_behavior = "replace",
			},
		})
	end,
}
