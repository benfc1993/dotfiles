local M = {}

M.attach = function(language)
    language = language:match("(_.)%A+") or language
    require("custom.lsp.test-runners").attach(language)
    require("custom.lsp.code-runner").attach(language)
end

return M
