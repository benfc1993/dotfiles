return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			messages = {
				enabled = false,
			},
			popupmenu = {
				enabled = false,
			},
			notify = {
				enabled = false,
			},
			lsp = {
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
				message = {
					enabled = false,
				},
			},
		})
	end,
}
