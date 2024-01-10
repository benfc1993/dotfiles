-- set leader
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true, remap = false })
vim.keymap.set('n', 'q', '<Nop>', { silent = true, remap = false })
vim.g.mapleader = ' '

-- move
nmap('<leader>n', '<cmd>NvimTreeToggle<CR>', '[NvimTree]Toggle nvim tree')
vim.keymap.set('n', '<esc>', '<nop>', { silent = true, remap = false })

-- use ; as :
nmap(';', ':')
vmap(';', ':')

nmap('<leader>f', vim.lsp.buf.format, 'lsp format buffer')

-- tmux navigation
nmap('<C-h>', '<cmd>TmuxNavigateLeft<CR>', '[TmuxNav] Left')
nmap('<C-j>', '<cmd>TmuxNavigateDown<CR>', '[TmuxNav] Down')
nmap('<C-k>', '<cmd>TmuxNavigateUp<CR>', '[TmuxNav] Up')
nmap('<C-l>', '<cmd>TmuxNavigateRight<CR>', '[TmuxNav] Right')

nmap("n", "nzzzv", 'keep cursor in center when next search match')
nmap("N", "Nzzzv", 'keep cursor in center when prev search match')

-- remap stop insert
imap('jk', '<cmd>stopinsert<CR>', 'Stop insert Insert')
tmap('jk', '<cmd>stopinsert<CR>', 'Exit insert Terminal')

-- mappings to write buffer
imap('jkl', '<cmd>stopinsert<CR><cmd>w<CR>', 'Stop insert and write Insert')
nmap('ss', '<cmd>w<CR>', 'Save from normal mode')

nmap("<C-w>", "<cmd>bw<CR>", "Close buffer")

vmap("J", ":m '>+1<CR>gv=gv", "move selection down")
vmap("K", ":m '<-2<CR>gv=gv", "move selection up")

nmap('<leader>hs', ':vsp <CR> | :wincmd l <CR>', 'split vertically')
nmap('<leader>vs', ':sp <CR> | :wincmd j <CR>', 'split horizontally')

nmap("<CR>", ":nohl<cr>", 'remove current search highlights')

nmap("<C-S-K>", "<cmd>cnext<CR>zz", 'next in quickfix list')
nmap("<C-S-J>", "<cmd>cprev<CR>zz", 'prev in quickfix list')


nmap("<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vmap("<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
