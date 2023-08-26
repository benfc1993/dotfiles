--- @type {[string]: {build: string, run: string, run_requires_build: boolean}}
local languages = {
    java = {
        run = './gradlew run',
        build = './gradlew build',
        run_requires_build = false
    },
    typescript = {
        run = 'yarn dev',
        build = 'yarn build',
        run_requires_build = false
    },
    cs = {
        run = 'dotnet run',
        build = 'dotnet build',
        run_requires_build = false
    }
}

local initialised_language = nil
local terminal = nil

local run_command = function(command)
    if terminal then
        terminal:close()
    end
    local toggleTerm = require("toggleterm.terminal").Terminal
    terminal = toggleTerm:new({
        close_on_exit = false,
        auto_scroll = true,
        cmd = command,
        persist_mode = true,
        on_open = function() vim.cmd('wincmd k') end
    })
    terminal:open()
end

local M = {}

M.attach = function(language)
    if not languages[language] or language == initialised_language then return end
    local language_code_runner = languages[language]

    nmap('<F5>', function() run_command(language_code_runner.run) end,
        '[CodeRunner] call run command in terminal')
    nmap('<S-F5>', function() run_command(language_code_runner.build) end,
        '[CodeRunner] call build command in terminal')

    print(language .. ' code runner services attached')
end

return M
