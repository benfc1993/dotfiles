local M = {}
M.logRocket = function()
	local word = vim.fn.expand("<cword>")
	print(word)
	local node = vim.treesitter.get_node({ bufnr = 0 })
	local tree = node:tree()
	local query = vim.treesitter.query.parse('typescript',
		[[([
(expression_statement (assignment_expression (member_expression)@name(#contains? @name ]] .. word .. [[)))
(expression_statement (call_expression (_(identifier)@name(#contains? @name ]] .. word .. [[))))
(variable_declarator (identifier)@name(#eq? @name ]] .. word .. [[))
(_ (formal_parameters (_(identifier)@name (#eq? @name ]] .. word .. [[))))
(member_expression (identifier)@name(#eq? @name ]] .. word .. [[))
(assignment_expression (identifier)@name(#eq? @name ]] .. word .. [[))
]@capture )]])
	-- local query = vim.treesitter.query.parse('typescript',
	-- 	[[((variable_declarator (identifier) @name (#eq? @name ]] .. word .. [[))]], word)

	local nodeName = nil
	local line = nil
	local pos = vim.api.nvim_win_get_cursor(0)
	for id, qnode, metadata in query:iter_captures(tree:root(), 0, pos[1] - 2, 1000) do
		if nodeName then break end
		local name = query.captures[id] -- name of the capture in the query
		print(name)
		if name == 'name' then
			local row, _, _, _ = qnode:parent():range()
			print(pos[1])
			print(row)
			if pos[1] - 1 == row then
				local row1, col1, row2, col2 = qnode:range() -- range of the capture
				print(qnode:range())
				nodeName = vim.api.nvim_buf_get_text(0, row1, col1, row2, col2, {})[1]
			end
		end
		if name == 'capture' then
			local row1, col1, row2, col2 = qnode:range() -- range of the capture
			print('row: ' .. row2)
			line = row2
		end
	end
	if nodeName == nil then return end
	print(nodeName)
	print(line)
	-- local line = node:end_()
	-- -- vim.cmd('o')
	local keys = vim.api.nvim_replace_termcodes(
		tostring(line + 1) .. 'G o console.log("' .. nodeName .. ':",' .. nodeName .. ')<ESC>:w<CR>', false, false,
		true)
	vim.api.nvim_feedkeys(keys, 'i', true)
	vim.cmd.stopinsert()
end

return M
