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
		}

		local lsputil = require("lspconfig.util")

		local root = lsputil.root_pattern("package.json")(vim.fn.expand("<abuf>"))

		local hasConfig = lsputil.path.exists(lsputil.path.join(root, ".eslintrc.json"))
			or lsputil.path.exists(lsputil.path.join(root, ".eslintrc.js"))

		if not hasConfig then
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
