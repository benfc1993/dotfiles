---@type ChadrcConfig 
local M = {}

M.ui = {theme = 'chadracula',
  hl_add = {
    ["branchCleanHl"] = { fg = "green" },
    ["branchModifiedHl"] = { fg = "red" }

  },
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

      -- table.insert(
      --   modules,
      --   2,
      --   (function()
      --     if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
      --       return ""
      --     end
      --
      --     local git_status = vim.b.gitsigns_status_dict
      --     local changed =  (git_status.changed and git_status.changed ~= 0) and true or false
      --     local added =  (git_status.added and git_status.added ~= 0) and true or false
      --     local removed =  (git_status.changed and git_status.changed ~= 0) and true or false
      --     return changed and added and removed and "\u{1F680}" or "\u{1F343}"
      --   end)()
      -- )
      modules[3] = (function()
        if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
          return ""
        end

        local git_status = vim.b.gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
        local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
        local branch_name = " " .. git_status.head
        local color = added and changed and removed and "%#branchModifiedHl#" or "%#branchCleanHl#"

        return "%#St_gitIcons#" .. color .. branch_name .. added .. changed .. removed
      end)()

    end,
  },
  transparency = true,
}

M.plugins = 'custom.plugins'
M.mappings = require 'custom.mappings'

return M

