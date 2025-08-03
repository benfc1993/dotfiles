require("core")

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
})

require("mason").setup()
require("nvim-treesitter").setup()
require("mini.pick").setup()
require("lazydev").setup({ ft = "lua" })

vim.cmd("colorscheme sonokai")
