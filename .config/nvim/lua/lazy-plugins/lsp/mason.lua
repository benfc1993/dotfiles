return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_lspconfig = require("mason-lspconfig")

		local servers = function()
			local list = require("lazy-plugins.lsp.utils.servers")
			local servers = {}
			for _, lsp in ipairs(list) do
				if lsp.mason == false then
					goto continue
				end

				table.insert(servers, lsp.name)

				::continue::
			end
		end

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = servers(), -- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d", -- js linter
				"js-debug-adapter",
			},
		})
	end,
}
