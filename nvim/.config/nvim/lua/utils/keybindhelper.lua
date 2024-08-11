local function options(opts, desc)
	local default_opts = {
		desc = desc,
		silent = true,
	}
	if opts then
		for k, v in pairs(opts) do
			default_opts[k] = v
		end
	end
	return default_opts
end
nmap = function(keys, func, desc, opts)
	vim.keymap.set("n", keys, func, options(opts, desc))
end

nrmap = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc, remap = false })
end

vmap = function(keys, func, desc, opts)
	vim.keymap.set("v", keys, func, options(opts, desc))
end

imap = function(keys, func, desc, opts)
	vim.keymap.set("i", keys, func, options(opts, desc))
end

tmap = function(keys, func, desc, opts)
	vim.keymap.set("t", keys, func, options(opts, desc))
end

local M = {}

return M
