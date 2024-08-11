return {
	"folke/todo-comments.nvim",
	config = function()
		nmap("<leader>ft", "<cmd>TodoTrouble<CR>", "[TODO] list todos")
		require("todo-comments").setup()
	end,
}
