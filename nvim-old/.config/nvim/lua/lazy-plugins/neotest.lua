local configFile = "jest.config.ts"

local set_config_file = function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	pickers
		.new({}, {
			prompt_title = "config file",
			finder = finders.new_oneshot_job({
				"rg",
				"--files",
				"-g",
				"jest.*config.*s",
			}, {}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function()
				actions.select_default:replace(function(prompt_buf)
					actions.close(prompt_buf)
					local selection = action_state.get_selected_entry()
					configFile = vim.fs.basename(vim.inspect(selection[1])):gsub('"', "")
				end)
				return true
			end,
		})
		:find()
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"haydenmeade/neotest-jest",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			discovery = {
				enabled = false,
			},
			adapters = {
				require("neotest-jest")({
					jestConfigFile = function()
						return configFile
					end,
					jest_test_discovery = true,
					env = { CI = true },
					cwd = function()
						vim.fn.getcwd()
					end,
				}),
			},
		})
		nmap("<leader>t", function()
			neotest.run.stop()
			neotest.run.run()
		end, "[NeoTest] run tests in file")
		nmap("<leader>tf", function()
			neotest.run.stop()
			neotest.run.run(vim.fn.expand("%"))
		end, "[NeoTest] run all tests in file")
		nmap("<leader>tt", function()
			neotest.run.stop()
			neotest.run.run(vim.fn.getcwd())
		end, "[NeoTest] run all tests")
		nmap("<leader>tl", function()
			neotest.run.stop()
			neotest.run.run_last()
		end, "[NeoTest] run last test")
		nmap("<leader>ts", "<cmd>Neotest summary<cr>", "[NeoTest] summary")
		nmap("<leader>tw", function()
			neotest.run.stop()
			neotest.run.run({
				vim.fn.getcwd(),
				jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch",
			})
		end, "[NeoTest] watch")
		nmap("<leader>td", neotest.run.stop, "[NeoTest] Stop process")
		nmap("<leader>tc", set_config_file, "[NeoTest] set config file")
		nmap("<leader>to", "<cmd>Neotest output<cr>", "[NeoTest] output")
	end,
}
