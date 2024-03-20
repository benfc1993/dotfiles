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

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			-- hijack_unnamed_buffer_when_opening = true,
			reload_on_bufenter = true,
			-- respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				-- update_root = true,
			},
			view = {
				preserve_window_proportions = true,
				centralize_selection = true,
				float = {
					enable = false,
					open_win_config = {
						width = vim.api.nvim_win_get_width(0) - 10,
						height = vim.api.nvim_win_get_height(0) - 10,
						row = 5,
						col = 5,
					},
				},
				width = {
					min = 30,
					max = -1,
				},
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			git = {
				enable = true,
				ignore = false,
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
			modified = {
				enable = true,
			},
		})
		nmap("<leader>n", "<cmd>NvimTreeToggle<CR>", "[NvimTree]Toggle nvim tree")
	end,
}
