return {
	"dmmulroy/tsc.nvim",
	-- dir = "/Users/ben.feldbergcollins/projects/personal/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_start_watch_mode = true,
			auto_open_qflist = false,
			auto_close_qflist = true,
			auto_focus_qflist = false,
			use_trouble_qflist = true,
			-- config_path = function()
			-- 	return vim.fn.input("config file path: ")
			-- end,
			flags = {
				watch = true,
			},
		})
		nmap("<C-b>", "<cmd>TSCOpen<CR>", "[TSC] open")
		nmap("<C-p>", "<cmd>TSCClose<CR>", "[TSC] close")
	end,
}
