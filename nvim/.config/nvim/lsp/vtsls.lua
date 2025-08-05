return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
	--[[ settings = {
		typescript = {
			preferences = {
				includeCompletionsForModuleExports = true,
				includeCompletionsForImportStatements = true,
				importModuleSpecifierPreference = "non-relative",
			},
		},
	}, ]]
}
