return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", desc = "[Trouble] Go to references" },
		{ "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>", desc = "[Trouble] Go to references" },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false win.position=left win.cols=100<cr>" },
		{
			"<leader>l",
			"<cmd>Trouble lsp toggle focus=false win.position=top<cr>",
			desc = "[Trouble] Lsp info",
		},
		{ "<leader>cl", "<cmd>Trouble qflist toggle<cr>", desc = "[Trouble] toggle quick fix list" },
	},
}
