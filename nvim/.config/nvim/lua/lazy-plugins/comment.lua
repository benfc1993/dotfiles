return {
	"numToStr/Comment.nvim",
	opts = function()
		require("Comment").setup({
			toggler = {
				line = "<leader>/",
				block = "<leader>/",
			},
			opleader = {
				line = "<leader>/",
				block = "<leader>/",
			},
		})
	end,
}
