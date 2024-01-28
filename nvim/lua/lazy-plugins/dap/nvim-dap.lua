return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = { "theHamsta/nvim-dap-virtual-text" },
		config = function()
			local dap = require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Boolean", linehl = "", numhl = "" })
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- This is the install location from mason js-debug-adapter
					args = {
						os.getenv("HOME")
							.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.expand("%"),
							completion = "file",
						})
						return (path and path ~= "") and path or dap.ABORT
					end,
					cwd = "${workspaceFolder}",
					runtimeArgs = { "-r", "ts-node/register" },
					sourceMaps = true,
					protocol = "inspector",
					runtimeExecutable = "node",
					args = { "${file}" },
					skipFiles = { "<node_internals>/**", "node_modules/**" },
					console = "integratedTerminal",
					resolveSourceMapLocations = { "!**/node_modules/**" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Debug",
					restart = true,
					sourceMaps = true,
					outDir = "${workspaceFolder}/lib",
				},
			}

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.expand("%"),
							completion = "file",
						})
						return (path and path ~= "") and path or dap.ABORT
					end,
					cwd = "${workspaceFolder}",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Debug",
					restart = true,
					sourceMaps = true,
					outDir = "${workspaceFolder}/lib",
				},
			}

			nmap("<leader>d", "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint")
			nmap("<leader>da", dap.continue, "[DAP] Run or Continue Debug")
			nmap("<leader>ds", dap.step_over, "[DAP] Step over")
			nmap("<leader>di", dap.step_into, "[DAP] Step over")
			nmap("<leader>de", function()
				require("dapui").close()
				dap.terminate()
			end, "[DAP] Run or Continue Debug")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
