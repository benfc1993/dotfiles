return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		local jdtlsCmd = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/jdtls"
		local lazyInstallPath = os.getenv("HOME") .. "/.local/share/nvim/lazy"
		local bundles = {
			vim.fn.glob(
				lazyInstallPath
					.. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
				true
			),
		}

		vim.list_extend(
			bundles,
			vim.split(vim.fn.glob(lazyInstallPath .. "/vscode-java-test/server/*.jar", true), "\n")
		)

		local config = {
			cmd = { jdtlsCmd },
			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
			init_options = {
				bundles = bundles,
			},
			settings = {

				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				format = {
					enabled = true,
				},

				signatureHelp = { enabled = true },
			},
			on_attach = function()
				local jdtls = require("jdtls")

				jdtls.setup_dap({ hotcodereplace = "auto" })
				require("jdtls.dap").setup_dap_main_class_configs()

				nmap("<leader>df", jdtls.test_class, "[DAP] Java debug current class")
				nmap("<leader>dn", jdtls.test_nearest_method, "[DAP] Java debug nearest method")
			end,
		}
		require("jdtls").start_or_attach(config)
	end,
}
