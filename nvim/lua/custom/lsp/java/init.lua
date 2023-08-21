local M = {}

M.attach = function()
    local runner = require("custom.lsp.java.run")
    local terminal = runner.create_terminal()
    nmap('<F5>', function() runner.run(terminal) end, '[Java] run')
    nmap('<F6>', function() runner.test(terminal) end, '[Java] test')
    nmap('<leader>t', require("custom.lsp.java.create-test-file").create_class_test, '[Java] create class test')

    require("custom.lsp.java.testing").setup()
end

return M