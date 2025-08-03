vim.keymap.set({ "i", "t" }, "jk", "<cmd>stopinsert<CR>")
vim.keymap.set("i", "jkl", "<cmd>stopinsert<cr><cmd>w<cr>")
vim.keymap.set("n", "ss", "<cmd>stopinsert<cr><cmd>w<cr>")

vim.keymap.set({ "n", "v", "x" }, ";", ":")
local M = {}

M.netrw_open = false

vim.keymap.set("n", "<leader>n", function()
	if M.netrw_open then
		M.netrw_open = false
		return ":Lexplore<CR>"
	end
	M.netrw_open = true
	return ":Lexplore %:p:h<CR>"
end, { expr = true, silent = true })

local netrw_group = vim.api.nvim_create_augroup("netrw_mapping", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = netrw_group,
	pattern = "netrw",
	callback = function(ev)
		M.netrw_open = true
		vim.keymap.set("n", "<leader>n", ":Lexplore<CR>", { silent = true, buffer = ev.buf })
	end,
})

-- window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":bdelete!<CR>", { silent = true })
--move window
vim.keymap.set("n", "<C-w>h", "<C-w>H", { silent = true })
vim.keymap.set("n", "<C-w>j", "<C-w>J", { silent = true })
vim.keymap.set("n", "<C-w>k", "<C-w>K", { silent = true })
vim.keymap.set("n", "<C-w>l", "<C-w>L", { silent = true })

-- search centering
vim.keymap.set("n", "n", "nzzzv", { desc = "keep cursor in center when next search match", silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "keep cursor in center when prev search match", silent = true })
-- move centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- terminal
vim.keymap.set("n", "<C-q>", ":topleft 10split<CR> :term<CR>:startinsert<CR>", { silent = true })

vim.keymap.set("n", "ns", "]sz=")
vim.keymap.set("n", "sg", "z=")

-- LSP

vim.keymap.set("i", "<M-space>", vim.lsp.completion.get, { desc = "open autocomplete" })

vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	else
		return "<Tab>"
	end
end, { expr = true, noremap = false, desc = "complete autocomplete with Tab" })

vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>fa", "<cmd>Pick grep_live<CR>")

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>w", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)

-- delete keeping yank
vim.keymap.set("n", "d", '"_d', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "D", '"_D', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "c", '"_c', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "cc", '"_S', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "C", '"_C', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "s", '"_s', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "S", '"_S', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "c", '"_c', { desc = "Delete without yank", silent = true, remap = false })

vim.keymap.set("v", "d", '"_d', { desc = "Delete without yank", silent = true })
vim.keymap.set("v", "dd", '"_dd', { desc = "Delete without yank", silent = true })
vim.keymap.set("v", "cc", '"_S', { desc = "Delete without yank", silent = true })
vim.keymap.set("v", "C", '"_C', { desc = "Delete without yank", silent = true })
vim.keymap.set("v", "s", '"_s', { desc = "Delete without yank", silent = true })
vim.keymap.set("v", "S", '"_S', { desc = "Delete without yank", silent = true })

vim.keymap.set("n", "x", '"_x', { desc = "Delete without yank", silent = true, remap = false })
vim.keymap.set("n", "X", '"_X', { desc = "Delete without yank", silent = true, remap = false })
