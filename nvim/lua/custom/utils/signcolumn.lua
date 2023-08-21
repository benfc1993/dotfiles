signs = {}

function ReturnHighlightTerm(group, term)
    local output = vim.fn.execute('hi ' .. group, 'silent')
    return output:match(term .. '=(.*)%s*')
end

local signcolumnbg = ReturnHighlightTerm('SignColumn', 'guibg')

vim.cmd('hi! signsredhl guifg=red guibg=' .. signcolumnbg)
vim.cmd('hi signsgreenhl guifg=SeaGreen guibg=' .. signcolumnbg)
vim.cmd('hi! signsbluehl gui=bold guifg=SlateBlue guibg=' .. signcolumnbg)
vim.cmd('hi! signsyellowhl guifg=yellow guibg=' .. signcolumnbg)

vim.fn.sign_define('tick', { text = " \u{2714}", texthl = 'signsgreenhl' })
vim.fn.sign_define('cross', { text = " \u{26CC}", texthl = 'signsredhl' })
vim.fn.sign_define('flask', { text = "T\u{27A4}", texthl = 'signsbluehl' })

signs.symbols = {
    tick = {
        name = 'tick',
        id = 201
    },
    cross = {
        name = 'cross',
        id = 202
    },
    flask = {
        name = 'flask',
        id = 203
    }
}

--- add a symbol to the signcolumn
--- @param symbol {}
--- @param lnum integer
--- @param group string
--- @param buffer integer
--- @return nil
--- @overload fun(symbol: {}, lnum: integer, group?: string, buffer?: string)
--- @overload fun(symbol: {}, lnum: integer, group?: string, buffer?: integer)
signs.add_symbol = function(symbol, lnum, group, buffer)
    if not symbol or not lnum then return end

    group = group or ''
    buffer = buffer or vim.api.nvim_get_current_buf()

    vim.fn.sign_place(symbol.id, group, symbol.name, buffer, { lnum = lnum })
end

signs.clear_group = function(group)
    vim.fn.sign_unplace(group)
end

signs.clear_buffer = function(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()
    vim.fn.sign_unplace('*', { buffer = buffer })
end

signs.clear_symbol = function(symbol)
    vim.fn.sign_unplace('*', { id = symbol.id })
end

return signs
