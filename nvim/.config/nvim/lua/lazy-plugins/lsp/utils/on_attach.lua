local M = {}

M.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }
	nmap("gd", vim.lsp.buf.definition, "goto definition", opts)
	nmap("gi", vim.lsp.buf.implementation, "", opts)
	nmap("gt", vim.lsp.buf.type_definition, "", opts)
	nmap("K", vim.lsp.buf.hover, "", opts)
	nmap("<leader>vf", vim.diagnostic.open_float, "", opts)
	nmap("<leader>e", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "", opts)
	nmap("<leader>w", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "", opts)
	nmap([[<C-_>]], vim.lsp.buf.code_action, "", opts)
	nmap("<leader>h", vim.lsp.buf.signature_help, "", opts)
	nmap("<F2>", vim.lsp.buf.rename, "", opts)
	nmap("<leader>rr", "<cmd>LspRestart<cr>", "", opts)
end

return M
