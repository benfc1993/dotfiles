local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local bootstrap_packer = ensure_packer()
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use({
        'christoomey/vim-tmux-navigator',
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
        end
    })
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {                                 -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'folke/neodev.nvim', },
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' }, -- Required

        },
    }
    use({ "akinsho/toggleterm.nvim", tag = '*' })
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })
    use { 'nvim-tree/nvim-web-devicons' }
    use('nvim-tree/nvim-tree.lua')
    use({
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    })
    -- Themes
    use({
        'Mofiqul/dracula.nvim',
        as = 'dracula',
    })
    use("bluz71/vim-nightfly-colors")
    use("ellisonleao/gruvbox.nvim")

    if vim.fn.getcwd(0):find('configs') or bootstrap_packer then
        require('packer').sync()
    end
end)
