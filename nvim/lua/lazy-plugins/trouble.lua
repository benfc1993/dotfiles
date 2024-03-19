return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		position = "top",
	},
	config = function()
		nmap("<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "[Trouble] toggle" })
		nmap("gr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "[Trouble] go to references" })
	end,
}
