vim.opt.nu = true
vim.opt.relativenumber = true
vim.g.startup_disable_on_startup = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
-- vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.cursorline = true

vim.opt.updatetime = 0

vim.opt.timeoutlen = 300

vim.opt.spelllang = 'en_gb'
vim.opt.spellsuggest = 'best,5'
vim.opt.spell = true

vim.opt.clipboard = 'unnamedplus'
