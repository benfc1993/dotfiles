return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		position = "top",
		auto_open = true,
		auto_close = false,
	},
	config = function()
		nmap("<leader>xx", "<cmd>TroubleToggle<cr>", "[Trouble] toggle")
		nmap("gr", "<cmd>TroubleToggle lsp_references<cr>", "[Trouble] go to references")
	end,
}
