return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = { "theHamsta/nvim-dap-virtual-text" },
		config = function()
			local dap = require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Boolean", linehl = "", numhl = "" })

			local vscode_js_debug_location = os.getenv("HOME")
				.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

			for _, type in ipairs({
				"node",
				"chrome",
				"pwa-node",
				"pwa-chrome",
				"pwa-msedge",
				"node-terminal",
				"pwa-extensionHost",
			}) do
				dap.adapters[type] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = { vscode_js_debug_location, "${port}" },
					},
				}
			end

			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}

			local js_based_languages = { "javascript", "javascriptreact", "typescriptreact", "typescript" }

			for _, language in ipairs({ "javascript", "typescript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug",
						program = function()
							local path = vim.fn.input({
								prompt = "Path to entry point: ",
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
						name = "Attach",
						restart = true,
						sourceMaps = true,
						cwd = vim.fn.getcwd(),
						outDir = "${workspaceFolder}/lib",
					},
				}
			end

			dap.configurations.typescriptreact = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				{
					name = "Next.js: debug server-side",
					type = "pwa-node",
					request = "launch",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "npm",
					runtimeArgs = { "run-script", "dev" },
					sourceMaps = true,
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Auto attach",
					processId = require("dap.utils").pick_process,
					sourceMaps = true,
					cwd = vim.fn.getcwd(),
					protocol = "inspector",
				},
			}

			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
					launch_scene = true,
				},
			}

			nmap("<leader>d", "<cmd>DapToggleBreakpoint<cr>", "[DAP] Toggle breakpoint")
			nmap("<leader>da", function()
				if vim.fn.filereadable(".vscode/launch.json") then
					require("dap.ext.vscode").load_launchjs(nil, {
						["pwa-node"] = js_based_languages,
						["node"] = js_based_languages,
						["chrome"] = js_based_languages,
						["pwa-chrome"] = js_based_languages,
						["node-terminal"] = js_based_languages,
					})
				end
				dap.continue()
			end, "[DAP] Run or Continue Debug")
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
			require("nvim-dap-virtual-text").setup({})
		end,
	},
}
