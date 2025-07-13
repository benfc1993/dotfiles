return {
	cmd = { "cssmodules-language-server" },
	filetypes = { "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
	on_attach = require("core.lsp").on_attach,
}
