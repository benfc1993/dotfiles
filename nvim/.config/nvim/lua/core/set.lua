vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true -- highlights search matches
vim.opt.incsearch = true --
vim.opt.cmdheight = 2

vim.opt.termguicolors = true -- sets color matching for better themes

vim.opt.scrolloff = 8 -- scroll offset before moving page

vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best,5"
vim.opt.spelloptions = "camel"
vim.opt.spell = true

vim.opt.cursorline = true

vim.opt.updatetime = 0

vim.opt.timeoutlen = 300

vim.opt.clipboard = "unnamedplus" -- yank into machine clipboard

vim.opt.shortmess = "aWFlot"
