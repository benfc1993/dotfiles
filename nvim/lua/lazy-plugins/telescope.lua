return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		local theme = require("telescope.themes")
		nmap("<leader>ff", function()
			builtin.find_files(theme.get_dropdown({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } }))
		end, "Find files")
		nmap("<leader>b", builtin.buffers, "[Telescope] Find existing buffers")
		nmap("<leader>fg", builtin.git_files, "[Telescope] Find files in git repo")
		nmap("<leader>fa", function()
			builtin.live_grep(theme.get_dropdown())
		end, "[Telescope] Find strings in all files")
		nmap("<leader>fs", builtin.current_buffer_fuzzy_find, "[Telescope] find string in file")
		nmap("<leader>fh", builtin.help_tags, "[Telescope] Search help")
		nmap("<leader>fk", builtin.keymaps, "[telescope] Search key mappings")
		nmap("<leader>ft", require("telescope").extensions.todo.todo, "[telescope] TODOs")
		nmap("<leader>th", function()
			builtin.colorscheme({
				enable_preview = true,
			})
		end, "Change Color Scheme")
		nmap("gr", require("telescope.builtin").lsp_references, "[Telescope] Go To references")

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"target/",
					".mvn/",
					"build/",
					"gradle/",
					"dist",
					"package-lock.json",
				},
				path_display = { "smart" },
			},
		})
	end,
}
