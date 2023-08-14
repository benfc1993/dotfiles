---@type ChadrcConfig 
local M = {}

M.ui = {theme = 'chadracula',
  statusline = {
    -- modules arg here is the default table of modules
    overriden_modules = function(modules)
      -- modules[1] = (function()
      --   return "MODE!"
      -- end)()

      -- adding a module between 2 modules
      -- Use the table.insert functin to insert at specific index
      -- This will insert a new module at index 2 and previous index 2 will become 3 now
      -- if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
      --   return ""
      -- end

      local git_status = vim.b.gitsigns_status_dict
      local message =  git_status.changed  and "\u{1F601}" or "no chage"

      table.insert(
        modules,
        2,
        (function()
          return message
        end)()
      )
    end,
  },
  transparency = true,
}

M.plugins = 'custom.plugins'
M.mappings = require 'custom.mappings'

return M

