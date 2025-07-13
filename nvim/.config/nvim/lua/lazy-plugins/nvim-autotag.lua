local filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"html",
}
return {
	"windwp/nvim-ts-autotag",
	ft = filetypes,
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
