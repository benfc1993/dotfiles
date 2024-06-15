ColorMyPencils = function(color)
	color = color or SelectedColorScheme
	vim.cmd.colorscheme(color)
	vim.schedule(function()
		local highlights = { "Normal", "NormalNC", "NormalFloat", "MsgArea", "NvimTreeNormal" }
		for _, hi in ipairs(highlights) do
			vim.api.nvim_set_hl(0, hi, { bg = "none", ctermbg = "none", background = "none" })
		end

		vim.cmd("hi! Cursorline guibg=Grey10")
		vim.cmd("hi! CursorlineNr guibg=Grey10 guifg=#fabd2f")
	end)
end
