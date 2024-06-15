return {
	"dmmulroy/tsc.nvim",
	-- dir = "/Users/ben.feldbergcollins/projects/personal/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_start_watch_mode = false,
			auto_open_qflist = false,
			auto_close_qflist = true,
			auto_focus_qflist = false,
			use_trouble_qflist = true,
			run_as_monorepo = false,
			flags = {
				watch = true,
				build = false,
			},
		})
		nmap("<C-b>", "<cmd>TSCOpen<CR>", "[TSC] open")
		nmap("<C-p>", "<cmd>TSCClose<CR>", "[TSC] close")
	end,
}
