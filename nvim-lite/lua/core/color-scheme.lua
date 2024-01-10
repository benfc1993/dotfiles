ColorMyPencils = function(color)
	color = color or SelectedColorScheme
	vim.cmd.colorscheme(color)
	vim.schedule(function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.cmd('hi! Cursorline guibg=Grey10')
		vim.cmd('hi! CursorlineNr guibg=Grey10 guifg=#fabd2f')
	end)
end
