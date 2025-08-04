-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
-- vim.keymap.set("n", "q", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- move
vim.keymap.set("n", "<esc>", "<nop>", { silent = true, remap = false })

-- use ; as :
nmap(";", ":")
vmap(";", ":")

-- search centering
nmap("n", "nzzzv", "keep cursor in center when next search match")
nmap("N", "Nzzzv", "keep cursor in center when prev search match")
-- move centering
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- remap stop insert
imap("jk", "<cmd>stopinsert<CR>", "Stop insert Insert")
tmap("jk", "<cmd>stopinsert<CR>", "Exit insert Terminal")
tmap("<Esc>", "<cmd>stopinsert<CR>", "Exit insert Terminal")

--indenting
vmap(">", ">gv", "indent stay in insert")
vmap("<", "<gv", "indent stay in insert")

-- mappings to write buffer
imap("jkl", "<cmd>stopinsert<CR><cmd>w<CR>", "Stop insert and write Insert")
nmap("ss", "<cmd>w<CR>", "Save from normal mode")

imap("<C-p>", '<C-r>"', "Paste in insert mode")

nmap("<leader>q", "<cmd>bw!<CR>", "Close buffer")

-- window move remapping
-- move focus
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")
--move window
nmap("<C-w>h", "<C-w>H")
nmap("<C-w>j", "<C-w>J")
nmap("<C-w>k", "<C-w>K")
nmap("<C-w>l", "<C-w>L")

-- terminal
nmap("<C-q>", "<cmd>topleft 10sp<CR><cmd>noa<CR><cmd>term<CR><cmd>startinsert<CR>", "Open a terminal")
nmap("<M-q>", "<cmd>tabnew<CR><cmd>term<CR><cmd>startinsert<CR>", "Open a terminal in a new tab")
tmap("<leader>q", "<cmd>bw!<CR>", "Close buffer")

-- tabs
nmap("<leader>tn", "<cmd>tabnew<cr><cmd>NvimTreeOpen<cr>", "[Tabs] New tab")
nmap("<leader>tq", "<cmd>tabclose<cr>", "[Tabs] Close tab")
nmap("<leader>kw", "<cmd>tabonly<cr>", "[Tabs] close other tabs")
nmap("<leader><Tab>", "<cmd>tabn<cr>", "[Tabs] Next tab")

-- spell check
nmap("sg", "z=")

nmap("<CR>", ":nohl<cr>", "remove current search highlights")

nmap("<C-g>", "<cmd>DiffviewOpen<cr>", "[Diff view] Open Diff view")

-- surround
vmap('"', ":'<,'>norm _i\"$a\"")
vmap("'", ":'<,'>norm _i'$a'")
vmap("{", ":'<,'>norm _i{$a}")
vmap("(", ":norm _i($a)<cr>")
vmap("[", ":'<,'>norm _i[$a]")
vmap("<", ":'<,'>norm _i<$a>")

-- delete keeping yank
nrmap("d", '"_d', "Delete without yank")
nrmap("dd", '"_dd', "Delete without yank")
nrmap("D", '"_D', "Delete without yank")
nrmap("c", '"_c', "Delete without yank")
nrmap("cc", '"_S', "Delete without yank")
nrmap("C", '"_C', "Delete without yank")
nrmap("s", '"_s', "Delete without yank")
nrmap("S", '"_S', "Delete without yank")
nrmap("c", '"_c', "Delete without yank")

vmap("d", '"_d', "Delete without yank")
vmap("dd", '"_dd', "Delete without yank")
vmap("cc", '"_S', "Delete without yank")
vmap("C", '"_C', "Delete without yank")
vmap("s", '"_s', "Delete without yank")
vmap("S", '"_S', "Delete without yank")

nrmap("x", '"_x', "Delete without yank")
nrmap("X", '"_X', "Delete without yank")

-- global marks
local prefixes = "m'"
local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #prefixes do
	local prefix = prefixes:sub(i, i)
	for j = 1, #letters do
		local lower_letter = letters:sub(j, j)
		local upper_letter = string.upper(lower_letter)
		nmap(prefix .. lower_letter, prefix .. upper_letter, "Mark " .. upper_letter)
		vmap(prefix .. lower_letter, prefix .. upper_letter, "Mark " .. upper_letter)
	end
end

-- goto:
nmap("gf", function()
	local line = vim.fn.expand("<cfile>")

	if line == nil then
		return
	end

	if line:match("(http:)") ~= nil or line:match("(https:)") ~= nil then
		vim.cmd("!open " .. line)
	end

	local path = line:match("([.%w]+/[%w/._-]+[.]%w+)")

	local line_nr = line:match("[#:]+(%w+)")

	if path == nil then
		return
	end
	print(vim.fn.expand("%:p:h/") .. path)

	if line_nr == nil then
		vim.cmd(":e! %:p:h/" .. path)
		return
	end

	line_nr = line_nr:gsub("%D+", "")

	vim.cmd(":e! %:p:h/" .. path)
	vim.cmd(":" .. line_nr)
end)
nmap("gx", function()
	vim.cmd("!open " .. vim.fn.expand("<cfile>"))
end, "Go to external", { silent = true })
