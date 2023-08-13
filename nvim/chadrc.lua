---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'chadracula'}
M.plugins = 'custom.plugins'
M.mappings = {
  general  = {
  n = {
    ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up" },
  }
  }
}
return M

