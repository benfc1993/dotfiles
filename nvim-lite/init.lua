require("utils")
require("core")
require("plugins")
require("colorScheme")

vim.api.nvim_create_autocmd({ "ColorScheme" }, {

	group = vim.api.nvim_create_augroup("colorSchemeGroup", { clear = true }),
	callback = function()
		local match = vim.fn.expand("<amatch>")
		ColorMyPencils(match)
		local file = assert(io.open(os.getenv("HOME") .. [[/.config/nvim/lua/colorScheme.lua]], "w+"))
		if file == nil then
			file = assert(io.open(os.getenv("HOME") .. [[/.config/nvim/lua/colorScheme.lua]], "w+"))
		end

		if file == nil then
			vim.print("No file")
			return ""
		end
		file:write('SelectedColorScheme = "' .. match .. '"')
		file:write("ColorMyPencils()")
		file:close()
	end,
})

require("plugins.timeout").StartTimeOut()
