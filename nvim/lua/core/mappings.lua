-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.keymap.set("n", "q", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- move
vim.keymap.set("n", "<esc>", "<nop>", { silent = true, remap = false })

-- use ; as :
nmap(";", ":")
vmap(";", ":")

nmap("<leader>f", vim.lsp.buf.format, "lsp format buffer")

nmap("n", "nzzzv", "keep cursor in center when next search match")
nmap("N", "Nzzzv", "keep cursor in center when prev search match")

-- remap stop insert
imap("jk", "<cmd>stopinsert<CR>", "Stop insert Insert")
tmap("jk", "<cmd>stopinsert<CR>", "Exit insert Terminal")
tmap("<Esc>", "<cmd>stopinsert<CR>", "Exit insert Terminal")

-- mappings to write buffer
imap("jkl", "<cmd>stopinsert<CR><cmd>w<CR>", "Stop insert and write Insert")
nmap("ss", "<cmd>w<CR>", "Save from normal mode")

imap("<C-p>", '<C-r>"', "Paste in insert mode")

nmap("<leader>q", "<cmd>bw!<CR>", "Close buffer")

-- terminal
nmap("<C-q>", "<cmd>10sp<CR><cmd>term<CR><cmd>startinsert<CR>", "Open a terminal")

vmap("J", ":m '>+1<CR>gv=gv", "move selection down")
vmap("K", ":m '<-2<CR>gv=gv", "move selection up")

nmap("<leader>hs", ":vsp <CR> | :wincmd l <CR>", "split vertically")
nmap("<leader>vs", ":sp <CR> | :wincmd j <CR>", "split horizontally")

nmap("<CR>", ":nohl<cr>", "remove current search highlights")

nmap("<leader>j", "<cmd>cnext<CR>zz", "next in quickfix list")
nmap("<leader>k", "<cmd>cprev<CR>zz", "prev in quickfix list")

nmap("<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end)
vmap("<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- Tabs
nmap("<leader>tn", "<cmd>tabnew<cr><cmd>NvimTreeOpen<cr>", "[Tabs] New tab")
nmap("<leader>tw", "<cmd>tabclose<cr>", "[Tabs] New tab")
nmap("<leader><Tab>", "<cmd>tabn<cr>", "[Tabs] Next tab")
nmap("<leader><S-Tab>", "<cmd>tabp<cr>", "[Tabs] Prev tab")
nmap("<leader>kw", "<cmd>tabonly<cr>", "[Tabs] close other tabs")

nmap("<C-g>", "<cmd>DiffviewOpen<cr>", "[Diff view] Open Diff view")

-- window move remapping
nmap("<C-w>h", "<C-w>H")
nmap("<C-w>j", "<C-w>J")
nmap("<C-w>k", "<C-w>K")
nmap("<C-w>l", "<C-w>L")
