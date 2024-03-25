return {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_start_watch_mode = true,
			auto_open_qflist = false,
			auto_close_qflist = true,
			auto_focus_qflist = false,
			use_trouble_qflist = true,
			flags = {
				watch = true,
			},
		})
		nmap("<C-b>", "<cmd>TSCOpen<CR>", "[TSC] open")
		nmap("<C-p>", "<cmd>TSCClose<CR>", "[TSC] close")
	end,
}
