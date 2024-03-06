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
		local types = require("cmp.types")
		local compare = require("cmp.config.compare")

		-- local modified_priority = {
		-- 	[types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
		-- 	[types.lsp.CompletionItemKind.Snippet] = 0, -- top
		-- 	[types.lsp.CompletionItemKind.Keyword] = 0, -- top
		-- 	[types.lsp.CompletionItemKind.Text] = 1001, -- bottom
		-- }
		-- ---@param kind integer: kind of completion entry
		-- local function modified_kind(kind)
		-- 	return modified_priority[kind] or kind
		-- end

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
			-- sorting = {
			-- 	-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
			-- 	comparators = {
			-- 		compare.offset,
			-- 		compare.exact,
			-- 		function(entry1, entry2) -- sort by length ignoring "=~"
			-- 			local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
			-- 			local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
			-- 			if len1 ~= len2 then
			-- 				return len1 - len2 < 0
			-- 			end
			-- 		end,
			-- 		compare.recently_used,
			-- 		function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
			-- 			local kind1 = modified_kind(entry1:get_kind())
			-- 			local kind2 = modified_kind(entry2:get_kind())
			-- 			if kind1 ~= kind2 then
			-- 				return kind1 - kind2 < 0
			-- 			end
			-- 		end,
			-- 		function(entry1, entry2) -- score by lsp, if available
			-- 			local t1 = entry1.completion_item.sortText
			-- 			local t2 = entry2.completion_item.sortText
			-- 			if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
			-- 				return t1 < t2
			-- 			end
			-- 		end,
			-- 		compare.score,
			-- 		compare.order,
			-- 	},
			-- },
		})
	end,
}
