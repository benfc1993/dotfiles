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
					jestConfigFile = "jest.config.ts",
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
	end,
}
