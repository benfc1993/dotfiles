local M = {}

M.create_terminal = function()
    local toggleTerm = require("toggleterm.terminal").Terminal
    local testTerm = toggleTerm:new({ close_on_exit = false, auto_scroll = false, cmd = ':bd' })
    return testTerm
end

M.run = function(terminal)
    local toggleTerm = require("toggleterm")
    toggleTerm.exec('./gradlew run', terminal.id)
end

M.test = function(terminal)
    local toggleTerm = require("toggleterm")
    toggleTerm.exec('./gradlew test', terminal.id)
end

return M
