return {
	{
		"folke/zen-mode.nvim",
		opts = {
			plugins = {
				alacrity = { font = "16" },
			},
		},
		config = {
			nmap("<leader>zz", "<cmd>ZenMode<cr>", "[Zen] enable zen mode"),
		},
	},
	{ "folke/twilight.nvim" },
}
