return {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_open_qflist = false,
			auto_close_qflist = true,
		})
	end,
}
