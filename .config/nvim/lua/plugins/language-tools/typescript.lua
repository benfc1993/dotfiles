local M = {}

local filetypes = {
	typescript = "typescript",
	typescriptreact = "tsx",
	javascript = "javascript",
	javascriptreact = "jsx",
}

M.logRocket = function()
	local word = vim.fn.expand("<cword>")

	local node = vim.treesitter.get_node({ bufnr = 0 })

	local tree = node:tree()

	local query = vim.treesitter.query.parse(filetypes[vim.bo.filetype], [[([
(expression_statement (assignment_expression (member_expression)@name(#contains? @name ]] .. word .. [[)))
(expression_statement (call_expression (_(identifier)@name(#contains? @name ]] .. word .. [[))))
(variable_declarator (identifier)@name(#eq? @name ]] .. word .. [[))
(variable_declarator (object_pattern (shorthand_property_identifier_pattern)@name(#eq? @name ]] .. word .. [[)))
(_ (formal_parameters (_(identifier)@name (#eq? @name ]] .. word .. [[))))
(member_expression (identifier)@name(#eq? @name ]] .. word .. [[))
(assignment_expression (identifier)@name(#eq? @name ]] .. word .. [[))
]@capture )]])

	local nodeName = nil
	local line = nil
	local pos = vim.api.nvim_win_get_cursor(0)
	for id, qnode, metadata in query:iter_captures(tree:root(), 0, pos[1] - 2, 1000) do
		local name = query.captures[id] -- name of the capture in the query

		if name == "name" then
			local row, _, _, _ = qnode:parent():range()
			if pos[1] - 1 == row then
				local row1, col1, row2, col2 = qnode:range() -- range of the capture
				nodeName = vim.api.nvim_buf_get_text(0, row1, col1, row2, col2, {})[1]
			end
		end
		if name == "capture" then
			local row1, col1, row2, col2 = qnode:range() -- range of the capture
			line = row2
		end
	end
	if nodeName == nil then
		return
	end
	local keys = vim.api.nvim_replace_termcodes(
		tostring(line + 1) .. 'G o console.log("' .. nodeName .. ':",' .. nodeName .. ")<ESC>:w<CR>",
		false,
		false,
		true
	)
	vim.api.nvim_feedkeys(keys, "i", true)
	vim.cmd.stopinsert()
end

return M
