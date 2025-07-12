local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- vim.opt.rtp:remove("/Users/ben.feldbergcollins/nvim/lib/nvim")

require("lazy").setup({
	{ "nvim-neotest/nvim-nio" },
	{ import = "lazy-plugins" },
	{ import = "lazy-plugins.lsp" },
	{ import = "lazy-plugins.dap" },
}, {
	performance = {
		rtp = {
			reset = false,
		},
	},
	change_detection = {
		enabled = true, -- automatically check for config file changes and reload the ui
		notify = false, -- turn off notifications whenever plugin changes are made
	},
})
