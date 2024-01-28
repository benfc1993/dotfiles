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
			adapters = {
				require("neotest-jest")({
					-- jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h"))
					-- 	.. " --watch",
					jestConfigFile = "jest.config.ts",
					-- jest_test_discovery = true,
					env = { CI = true },
					cwd = function()
						vim.fn.getcwd()
					end,
				}),
			},
		})
		nmap("<leader>t", neotest.run.run, "[NeoTest] run tests in file")
		nmap("<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, "[NeoTest] run all tests in file")
		nmap("<leader>tt", function()
			neotest.run.run(vim.fn.getcwd())
		end, "[NeoTest] run all tests")
		nmap("<leader>ts", "<cmd>Neotest summary<cr>", "[NeoTest] summary")
	end,
}
