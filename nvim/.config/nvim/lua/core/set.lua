vim.o.number = true
vim.o.background = "dark"
vim.g.everforest_background = "hard"
vim.g.sonokai_style = "andromeda"
vim.g.everforest_enable_italic = true
vim.o.termguicolors = true

vim.opt.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2) -- scroll offset before moving page

vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best,5"
vim.opt.spelloptions = "camel"
vim.opt.spell = true

vim.opt.cursorline = true

vim.opt.updatetime = 0

vim.opt.timeoutlen = 300

vim.opt.clipboard = "unnamedplus" -- yank into machine clipboard

vim.opt.shortmess = "aWFlot"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.o.wrap = false
vim.o.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noinsert,fuzzy,popup"
