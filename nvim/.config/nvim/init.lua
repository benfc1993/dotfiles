require("core")
require("plugin")

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "http://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/sainnhe/everforest" },
	{ src = "https://github.com/sainnhe/sonokai" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/chrisgrieser/nvim-early-retirement" },
	{ src = "https://github.com/saghen/blink.cmp",                           version = 'v1.6.0' },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" }
})

-- disable netrw at the very start of your init.lua

require("mason").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = { "typescript", "lua", "tsx" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})
require("mini.pick").setup()
require("lazydev").setup({ ft = "lua" })
require("diffview").setup({
	hooks = {
		view_opened = function(view)
			vim.cmd("windo set nowinfixheight")
			vim.cmd("wincmd h")
			vim.cmd("wincmd J")
			vim.cmd("wincmd k")
			vim.cmd("wincmd K")
			vim.cmd("wincmd =")
			--[[ vim.cmd("<cmd>windo set nowinfixheight<CR><C-w>l<C-w>K<C-w>j<C-w>K<cmd>wincmd =<CR>") ]]
		end,
	},
})

require('early-retirement').setup({ retirementAgeMins = 5 })
--require('typescript-tools').setup({})
require('conform').setup({

	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		lua = { "stylua" },
		sh = { "beautysh" },
		zsh = { "beautysh" },
		gdscript = { "gdformat" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},

})


require("blink.cmp").setup({
	--				snippets = { preset = "luasnip" },
	signature = { enabled = true },
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "normal",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			cmdline = {
				min_keyword_length = 2,
			},
		},
	},
	keymap = {
		["<Tab>"] = { "select_and_accept", "fallback" },
		["<M-i>"] = { "show" },
	},
	cmdline = {
		enabled = false,
		completion = { menu = { auto_show = true } },
		keymap = {
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
	},
	completion = {
		menu = {
			border = nil,
			scrolloff = 1,
			scrollbar = false,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label",      "label_description", gap = 1 },
					{ "kind" },
					{ "source_name" },
				},
			},
		},
		documentation = {
			window = {
				border = nil,
				scrollbar = false,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
})
require("Comment").setup({
	toggler = {
		line = "<leader>/",
		block = "<leader>/",
	},
	opleader = {
		line = "<leader>/",
		block = "<leader>/",
	},
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
})
vim.cmd("colorscheme gruvbox")
