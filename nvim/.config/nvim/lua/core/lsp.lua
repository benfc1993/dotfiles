-- to setup a new server look at the example files https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({ "lua_ls", "cssmodules_ls", "vtsls", "cssls", "tailwindcss", "graphql" })

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("i", "<Tab>", function()
		return vim.fn.pumvisible() == 1 and "<c-y>" or "<Tab>"
	end, { remap = false, expr = true })

	vim.keymap.set("i", "<cr>", function()
		return vim.fn.pumvisible() == 1 and "<C-E><cr>" or "<cr>"
	end, { remap = false, expr = true })

	nmap("gd", vim.lsp.buf.definition, "goto definition", opts)
	nmap("gi", vim.lsp.buf.implementation, "", opts)
	nmap("gt", vim.lsp.buf.type_definition, "", opts)
	nmap("K", vim.lsp.buf.hover, "", opts)
	nmap("<leader>vf", vim.diagnostic.open_float, "", opts)
	nmap("<leader>e", function()
		vim.diagnostic.goto_next({ wrap = true })
	end, "", opts)
	nmap("<leader>w", function()
		vim.diagnostic.goto_prev({ wrap = true })
	end, "", opts)
	nmap([[<C-_>]], vim.lsp.buf.code_action, "", opts)
	nmap("<F2>", vim.lsp.buf.rename, "", opts)
end

return M
