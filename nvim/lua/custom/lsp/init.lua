local M = {}

local Languages = {
    java = function()
        require("custom.lsp.java").attach()
    end,
    lua = function()
    end
}

M.attach = function(language)
    Languages[language]()
end

return M
