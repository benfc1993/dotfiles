local M = {}

local Languages = {
    java = function()
        local java = require("custom.lsp.java")
        if java.initialised then return end
        java.attach()
    end,
    lua = function()
    end
}

M.attach = function(language)
    require("custom.lsp.test-runners").attach(language)
    if Languages[language] then
        Languages[language]()
        vim.print(language .. ' services attached')
    end
end

return M
