local servers = {
	{ name = "html", mason = true, lsp = true },
	{ name = "cssls", mason = true, lsp = true },
	{ name = "bashls", mason = true, lsp = true },
	{ name = "vtsls", mason = true, lsp = true },
	-- { name = "tsserver", mason = true, lsp = true },
	{ name = "graphql", mason = true, lsp = true },
	{ name = "lua_ls", mason = true, lsp = true },
	{ name = "gdscript", mason = false, lsp = true },
	{ name = "tailwindcss", mason = true, lsp = true },
	{ name = "clangd", mason = true, lsp = true },
}
return servers
