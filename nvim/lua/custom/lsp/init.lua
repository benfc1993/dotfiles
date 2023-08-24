local M = {}

local Languages = {
    java = function()
        local java = require("custom.lsp.java")
        if java.initialised then return end
        java.attach()
    end,
    lua = function()
    end,
    typescript = function()
    end,
}

M.attach = function(language)
    language = language:match("(_.)%A+") or language
    if Languages[language] then
        require("custom.lsp.test-runners").attach(language)
        Languages[language]()
        print(language .. ' services attached')
    end
end

return M
