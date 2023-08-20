vim.print('mappings loaded')
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

vim.g.mapleader = " "

nmap("<leader>n", '<cmd>NvimTreeToggle<CR>', 'Toggle nvim tree')

-- TODO: replace with correct cmd
nmap("<C-h>", "<cmd>TmuxNavigateLeft<CR>")
nmap("<C-j>", "<cmd>TmuxNavigateDown<CR>")
nmap("<C-k>", "<cmd>TmuxNavigateUp<CR>")
nmap("<C-l>", "<cmd>TmuxNavigateRight<CR>")

nmap("<C-[>", "<cmd>bp<CR>")
nmap("<C-]>", "<cmd>bn<CR>")

vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")


nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nrmap("<C-u>", "<C-u>zz")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
nmap("<leader>Y", [["+Y]])
nmap("<leader>p", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

nmap("Q", "<nop>")
nmap("<C-f>", "<cmd>silent !tmux neww fileSearch<CR>")
nmap("<leader>f", vim.lsp.buf.format)

nmap("<C-S-K>", "<cmd>cnext<CR>zz")
nmap("<C-S-J>", "<cmd>cprev<CR>zz")
nmap("<leader>k", "<cmd>lnext<CR>zz")
nmap("<leader>j", "<cmd>lprev<CR>zz")

nmap("<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vmap("<leader>r", [["hy:%s/<C-r>h/<C-r>h/gI<left><left><left>]], "Replace selection globally")
nmap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

nmap("<leader>vpp", "<cmd>e ~/.config/nvim/lua/custom/packer.lua<CR>");

nmap("<leader><leader>", function()
    vim.cmd("so")
end)
