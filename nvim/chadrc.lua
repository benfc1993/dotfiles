---@type ChadrcConfig 
local M = {}

M.ui = {theme = 'chadracula',
  hl_add = {
    ["branchCleanHl"] = { fg = "green", bg = "NONE", sp = "NONE" },
    ["branchModifiedHl"] = { fg = "red", bg = "NONE", sp = "NONE" }
  },
  statusline = {
    overriden_modules = function(modules)
      modules[3] = (function()
        if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
          return ""
        end

        local git_status = vim.b.gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
        local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
        local branch_name = " " .. git_status.head
        local color = (added ~= "" or changed ~= "" or removed ~= "") and "%#branchModifiedHl#" or "%#branchCleanHl#"

        return "%#St_gitIcons#" .. color .. branch_name .. added .. changed .. removed
      end)()

    end,
  },
  transparency = true,
}

M.plugins = 'custom.plugins'
M.mappings = require 'custom.mappings'

return M

