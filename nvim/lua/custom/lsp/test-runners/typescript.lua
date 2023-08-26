local M = {}

M.pattern = '*.test.ts'

local test_marker_query_string = [[(
(expression_statement
    (call_expression
    function: [ (identifier) @name
        (member_expression
        object: (identifier) @name)]
    arguments: (arguments (string (string_fragment) @method_name))
    )
) @method
(#eq? @name it)
)]]


local parse_output = function(tests, data)
    print(vim.inspect(data))
    if not data then return end
    local json_data = nil
    for _, line in ipairs(data) do
        json_data = line:match("^{(.*)}\r$")
        if json_data then break end
    end

    print(vim.inspect(json_data))

    if not json_data then return end
    json_data = '{' .. json_data .. '}'

    local decoded_data = vim.fn.json_decode(json_data)

    if not decoded_data then return end

    for _, testFile in pairs(decoded_data.testResults) do
        local file = testFile.name:match(".+/(.*)[%.].*$")

        if not tests[file] then tests[file] = {} end

        for _, test in pairs(testFile.assertionResults) do
            local reason = {}
            for _, details in pairs(test.failureDetails) do
                table.insert(reason, details.matcherResult.message)
            end
            local method = test.title

            tests[file][method] = {
                status = test.status,
                file = file,
                method = method,
                reason = reason
            }
        end
    end
end

M.create_test_runner = function(runner_group)
    local single_test_command = function(method_name)
        local pattern = "'" .. method_name .. "'"
        return { 'yarn', 'test', '--json', '-t', pattern }
    end
    require("custom.lsp.test-runners.utils").create_test_runner(runner_group, 'typescript', "*.ts", parse_output,
        test_marker_query_string,
        { 'yarn', 'test', '--json' }, single_test_command)
end

return M
