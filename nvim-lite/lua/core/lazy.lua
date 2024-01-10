local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- fileBrowser
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},
	-- TmuxNavigation
	{
		'christoomey/vim-tmux-navigator',
		config = function()
			vim.g.tmux_navigator_no_mappings = 1
		end
	},
	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- code edititng
	-- auto commenting
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	-- treesitter
	'nvim-treesitter/nvim-treesitter',
	-- LSP

	'williamboman/mason.nvim',                   -- Optional
	'williamboman/mason-lspconfig.nvim',         -- Optional
	"neovim/nvim-lspconfig",

	{
		"antosha417/nvim-lsp-file-operations",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	-- cmp
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',

	-- formatting
    'jose-elias-alvarez/null-ls.nvim',

	-- Aesthetics
	-- lualine
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},

	--startup
	{
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	-- Themes
	{
		'Mofiqul/dracula.nvim',
		as = 'dracula',
	},
	"bluz71/vim-nightfly-colors",
	{ "catppuccin/nvim", as = "catppuccin" },
	"ellisonleao/gruvbox.nvim",

}

require("lazy").setup(plugins)
