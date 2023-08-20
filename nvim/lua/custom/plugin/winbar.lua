vim.api.nvim_create_autocmd({ 'DirChanged', 'CursorMoved', 'BufWinEnter', 'BufFilePost', 'InsertEnter', 'BufWritePost' },
    {
        group = vim.api.nvim_create_augroup('winBarGroup', { clear = true }),
        callback = function()
            local fileType = vim.fn.expand('%:e')
            if fileType == '' then
                return ''
            end

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
