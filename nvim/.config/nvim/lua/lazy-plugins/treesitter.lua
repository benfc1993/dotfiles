return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"regex",
				"markdown_inline",
				"javascript",
				"typescript",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"html",
				"css",
			},
		})
	end,
}
