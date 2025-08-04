return {
	"sindrets/diffview.nvim",

	config = function()
		require("diffview").setup({
			hooks = {
				view_opened = function(view)
					vim.cmd("windo set nowinfixheight")
					vim.cmd("wincmd h")
					vim.cmd("wincmd J")
					vim.cmd("wincmd k")
					vim.cmd("wincmd K")
					vim.cmd("wincmd =")
					--[[ vim.cmd("<cmd>windo set nowinfixheight<CR><C-w>l<C-w>K<C-w>j<C-w>K<cmd>wincmd =<CR>") ]]
				end,
			},
		})
	end,
}
