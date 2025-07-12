return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			gdscript = { "gdlint" },
		}

		local lsputil = require("lspconfig.util")

		local root = lsputil.root_pattern("package.json")(vim.fn.expand("<abuf>"))

		if root == nil then
			return
		end

		local hasConfig = vim.loop.fs_stat(table.concat({ root, ".eslintrc.json" }))
			or vim.loop.fs_stat(table.concat({ root, ".eslintrc.js" }))
			or vim.loop.fs_stat(table.concat({ root, ".eslintrc.cjs" }))

		if lint.linters_by_ft[vim.bo.filetype] ~= nil or not hasConfig then
			return
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
