return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local telescopeConfig = require("telescope.config")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local theme = require("telescope.themes")

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		local open_with_trouble = require("trouble.sources.telescope").open

		telescope.setup({
			defaults = {
				vimgrep_arguments = vimgrep_arguments,
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-q>"] = open_with_trouble,
					},
					n = { ["<C-q>"] = open_with_trouble },
				},
				file_ignore_patterns = {
					"^node_modules",
					"^target/",
					"^.mvn/",
					"^build/",
					"^gradle/",
					"^dist/",
					"%package-lock.json",
				},
				path_display = { "smart" },
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
				},
				grep_string = {
					additionsal_args = { "--hidden" },
				},
				live_grep = { additional_args = { "--hidden" } },
			},
		})

		nmap("<leader>ff", function()
			builtin.find_files(theme.get_dropdown({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } }))
		end, "Find files")
		nmap("<leader>fa", function()
			builtin.live_grep(theme.get_dropdown())
		end, "[Telescope] Find strings in all files")
		nmap("<leader>fs", builtin.current_buffer_fuzzy_find, "[Telescope] find string in file")
		nmap("<leader>fh", builtin.help_tags)
		nmap("<leader>fm", function()
			builtin.marks(theme.get_dropdown())
		end, "[Telescope] find marks")
		nmap("<leader>b", builtin.buffers, "[Telescope] Find existing buffers")
		nmap("<leader>th", function()
			builtin.colorscheme({
				enable_preview = true,
			})
		end, "Change Color Scheme")
	end,
}
