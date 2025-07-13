return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local telescopeConfig = require("telescope.config")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

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
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
				},
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
			mappings = {
				i = { ["<C-q>"] = open_with_trouble },
				n = { ["<C-q>"] = open_with_trouble },
			},
		})

		nmap("<leader>ff", builtin.find_files, "[Telescope] find file")
		nmap("<leader>fa", builtin.live_grep, "[Telescope] find string in cwd")
		nmap("<leader>fs", builtin.current_buffer_fuzzy_find, "[Telescope] find string in file")
		nmap("<leader>fh", builtin.help_tags)
		nmap("<leader>b", builtin.buffers, "[Telescope] Find existing buffers")
		nmap("<leader>th", function()
			builtin.colorscheme({
				enable_preview = true,
			})
		end, "Change Color Scheme")
	end,
}
