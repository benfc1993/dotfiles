local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          quit_on_open = true
        },
      },
      git = {
        enable = true
      },
      renderer = {

        icons = {
          show = {
            git = true
          },
        },
      }
    },
  },
}

return plugins
