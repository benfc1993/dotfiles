local M = {}

M.pattern = '*.java'

local test_marker_query_string = [[(
(method_declaration
    (modifiers
    (marker_annotation name: (identifier) @name)
    )
    (identifier) @method_name
    ) @method
(#eq? @name "%s")
)]]

local add_test = function(tests, test_line, status, reason)
    local file, method
    local i = 0
    for w in string.gmatch(test_line, "%S+") do
        if i == 0 then
            file = w:find('%A+') and w:gsub('%.', '/'):match(".+/(.*)[%.]?.*$") or w
        elseif i == 2 then
            method = w:gsub('%A', '')
        end
        i = i + 1
    end



    if not tests[file] then tests[file] = {} end
    tests[file][method] = {
        status = status,
        file = file,
        method = method,
        reason = reason
    }
end

local parse_output = function(tests, data)
    print(vim.inspect(data))
    if not data then return end
    local valid_lines = {}
    local testInfoReached = false
    for _, line in pairs(data) do
        if testInfoReached then
            testInfoReached = line:find('actionable tasks') == nil
            if testInfoReached and line ~= "" then
                table.insert(valid_lines, line)
            end
        else
            testInfoReached = line:match('> Task :app:test%A+') or line:match('> Task :app:test$')
        end
    end
    local held_line = nil
    local description_lines = {}

    local function try_add_fail_test()
        if held_line ~= nil then
            add_test(tests, held_line, 'failed', description_lines)
        end
        held_line = nil
    end

    for _, validLine in pairs(valid_lines) do
        if validLine:find("PASSED") then
            add_test(tests, validLine, 'passed')
            try_add_fail_test()
        elseif validLine:find("SKIPPED") then
            add_test(tests, validLine, 'skipped')
            try_add_fail_test()
        elseif validLine:find("FAILED") then
            try_add_fail_test()
            held_line = validLine
        elseif held_line ~= nil and validLine ~= '' then
            local trimed_line = validLine:gsub('^%s*(.-)%s*$', '%1')
            table.insert(description_lines, trimed_line)
        end
    end
    try_add_fail_test()
end

M.create_test_runner = function(runner_group)
    local single_test_command = function(method_name)
        local pattern = '*' .. method_name
        return { './gradlew', 'cleanTest', 'test', '--tests', pattern }
    end
    require("custom.lsp.test-runners.utils").create_test_runner(runner_group, 'java', "*.java", parse_output,
        test_marker_query_string,
        { './gradlew', 'test' }, single_test_command)
end

return M
