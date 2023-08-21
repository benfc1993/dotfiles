local M = {}

local ts_utils = require 'nvim-treesitter.ts_utils'

M.create_class_test = function()
    local current_node = ts_utils.get_node_at_cursor(0, true)
    if not current_node then return "" end

    local expr = current_node

    while expr do
        if expr:type() == 'class_declaration' then
            break
        end
        expr = expr:parent()
    end

    if not expr then return "" end

    local prev_child = vim.treesitter.get_node_text(expr:child(0), 0)
    local class_name = ""
    for i = 1, expr:child_count() - 1, 1
    do
        if prev_child == "class" then
            class_name = vim.treesitter.get_node_text(expr:child(i), 0)
            break
        end
        prev_child = vim.treesitter.get_node_text(expr:child(i), 0)
    end

    if class_name == "" then return end



    local filePath = vim.fn.expand("%:~:.")
    local testPath = string.gsub(filePath, "/main/", "/test/", 1):gsub(class_name .. ".java",
        class_name .. "Test.java")

    local endIndex, _ = string.find(filePath, ".java", 0, true)
    local _, startIndex = string.find(filePath, "java/", 0, true)

    local packageName = string.sub(filePath, startIndex + 1, endIndex - 2 - class_name:len()):gsub(
        "/",
        ".")
    local fr = io.open(testPath, 'r')
    if fr == nil then
        local TestFile = io.open(testPath, 'w')

        if not TestFile then
            print('Can\'t create file at: ' .. testPath); return 'File Error';
        end

        TestFile:write('package ' .. packageName .. ';\n\npublic class ' .. class_name .. 'Test {\n}')

        TestFile:close()
    end
    vim.cmd('e ' .. testPath)
end

return M
