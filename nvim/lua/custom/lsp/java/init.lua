local M = {}

M.initialised = false

M.attach = function()
    if M.initialised then return end
    local runner = require("custom.lsp.java.run")
    local terminal = runner.create_terminal()
    nmap('<leader>t', require("custom.lsp.java.create-test-file").create_class_test, '[Java] create class test')

    M.initialised = true
end

return M
