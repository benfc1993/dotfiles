return {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
			auto_start_watch_mode = true,
			auto_open_qflist = true,
			auto_close_qflist = true,
			flags = {
				watch = true,
			},
		})
		vim.api.nvim_create_augroup("trouble-quickfix", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
			group = "trouble-quickfix",
			callback = function()
				if vim.bo.buftype == "quickfix" then
					print(#(vim.fn.getqflist()))
					if #(vim.fn.getqflist()) > 0 then
						vim.schedule(function()
							vim.cmd("Trouble quickfix")
						end)
						vim.schedule(function()
							vim.cmd("ccl")
						end)
					else
						vim.schedule(function()
							vim.cmd("TroubleClose")
						end)
					end
				end
			end,
		})
	end,
}
