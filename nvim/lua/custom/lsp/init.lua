local M = {}

local Languages = {
    java = function()
        require("custom.lsp.java").attach()
    end,
    lua = function()
    end
}

M.attach = function(language)
    if Languages[language] then
        Languages[language]()
        vim.print(language .. ' services attached')
    end
end

return M
