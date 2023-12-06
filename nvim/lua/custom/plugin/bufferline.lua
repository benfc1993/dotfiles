require('bufferline').setup { options = { diagnostics = 'nvim_lsp', diagnostics_update_in_insert = true } }
local bufferline = require('bufferline')
nmap('<leader><Tab>', function()
    bufferline.cycle(1)
end, '[bufferline] cycle forward')
nmap('<leader><S-Tab>', function()
    bufferline.cycle(-1)
end, '[bufferline] cycle forward')
nmap('<C-W>', bufferline.close_others, '[Bufferline] close others')
for i = 1, 9, 1 do
    nmap('<leader>' .. i, function()
            bufferline.go_to(i)
        end,
        '[Bufferline] go to ' .. i)
end
