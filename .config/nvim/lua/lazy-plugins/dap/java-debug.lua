return {
	{
		"microsoft/java-debug",
		build = "./mvnw clean install",
		dependancies = {
			"mfussenegger/nvim-jdtls",
		},
	},
	{
		"microsoft/vscode-java-test",
		build = { "npm install && npm run build-plugin" },
		dependancies = {
			"mfussenegger/nvim-jdtls",
		},
	},
}
