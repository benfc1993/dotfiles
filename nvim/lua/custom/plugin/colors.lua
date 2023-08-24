ColorMyPencils = function(color)
    color = color or SelectedColorScheme
    vim.cmd.colorscheme(color)
    vim.schedule(function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        require("custom.utils.signcolumn").setup()
    end)
end
