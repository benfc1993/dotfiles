vim.o.number = true
vim.o.background = "dark"
vim.g.everforest_background = "hard"
vim.g.sonokai_style = "andromeda"
vim.g.everforest_enable_italic = true
vim.o.termguicolors = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.scrolloff = math.floor(vim.api.nvim_win_get_height(0) / 2) -- scroll offset before moving page

vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best,5"
vim.opt.spelloptions = "camel"
vim.opt.spell = true
vim.opt.spellfile = os.getenv("HOME") .. "/dotfiles/nvim/.config/nvim/spell/en.utf-8.add"

vim.opt.cursorline = true
vim.opt.updatetime = 0
vim.opt.timeoutlen = 300
vim.opt.clipboard = "unnamedplus" -- yank into machine clipboard

vim.opt.shortmess = "aWFlot"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.wrap = false
vim.o.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
--vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"

vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noinsert,fuzzy,popup"
