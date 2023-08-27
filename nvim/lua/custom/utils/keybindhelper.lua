nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
end

nrmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc, remap = false })
end

vmap = function(keys, func, desc)
    vim.keymap.set('v', keys, func, { desc = desc })
end

imap = function(keys, func, desc)
    vim.keymap.set('i', keys, func, { desc = desc })
end

local M = {}

return M
