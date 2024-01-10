require("mason").setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason-lspconfig").setup({
	capabilities = capabilities
})
require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {
			on_attach = function()
				local opts = { buffer = 0, remap = false }
				nmap("gd", vim.lsp.buf.definition, '',opts)
				nmap("gt", vim.lsp.buf.type_definition,'', opts)
				nmap("K", vim.lsp.buf.hover,'', opts)
				nmap("<leader>vf", vim.diagnostic.open_float,'', opts)
				nmap("<leader>e", vim.diagnostic.goto_next,'', opts)
				nmap("<leader>w", vim.diagnostic.goto_prev,'', opts)
				nmap([[<C-_>]], vim.lsp.buf.code_action,'', opts)
				nmap("<leader>h", vim.lsp.buf.signature_help,'', opts)
			end
		}
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function ()
	--	require("rust-tools").setup {}
	-- end
}
