nmap("<leader>n", vim.cmd.Ex)

-- TODO: replace with correct cmd
nmap("<C-h>", "<cmd>TmuxNavigateLeft<CR>")
nmap("<C-j>", "<cmd>TmuxNavigateDown<CR>")
nmap("<C-k>", "<cmd>TmuxNavigateUp<CR>")
nmap("<C-l>", "<cmd>TmuxNavigateRight<CR>")

nmap("<C-]>", "<cmd>bp<CR>")
nmap("<C-[>", "<cmd>bn<CR>")

vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")


nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")
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

nmap("<C-K>", "<cmd>cnext<CR>zz")
nmap("<C-J>", "<cmd>cprev<CR>zz")
nmap("<leader>k", "<cmd>lnext<CR>zz")
nmap("<leader>j", "<cmd>lprev<CR>zz")

nmap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vmap("<C-r>", "hy:%s/<C-r>h//gc<left><left><left>", "Replace selection globally")
nmap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

nmap("<leader>vpp", "<cmd>e ~/.config/nvim/lua/custom/packer.lua<CR>");

nmap("<leader><leader>", function()
    vim.cmd("so")
end)
