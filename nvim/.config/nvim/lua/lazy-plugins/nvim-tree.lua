return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			reload_on_bufenter = true,
			update_focused_file = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
					resize_window = false,
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				severity = {
					min = vim.diagnostic.severity.WARN,
					max = vim.diagnostic.severity.ERROR,
				},
			},
		})
		map("<leader>n", "<cmd>NvimTreeToggle<CR>")
	end,
}
