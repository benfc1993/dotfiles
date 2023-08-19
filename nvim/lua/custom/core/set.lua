vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 0

--vim.opt.colorcolumn = "80"
vim.api.nvim_create_autocmd({ 'DirChanged', 'CursorMoved', 'BufWinEnter', 'BufFilePost', 'InsertEnter', 'BufWritePost' },
    {
        group = vim.api.nvim_create_augroup('winBarGroup', { clear = true }),
        callback = function()
            local fileType = vim.fn.expand('%:e')
            if fileType == '' then
                return ''
            end
            -- print(fileType)

            vim.opt_local.winbar = (function()
                local filePath = vim.fn.expand('%:~:.:h')
                local fileName = vim.fn.expand('%:t')
                local file_icon = require('nvim-web-devicons').get_icon(fileName, fileType, { default = true })
                local hl_winbar_file_icon = "DevIcon" .. fileType
                file_icon = '%#' .. hl_winbar_file_icon .. '#' .. file_icon .. ' %*'

                return file_icon .. filePath .. '/' .. fileName .. '%=%m'
            end)()
        end
    })
