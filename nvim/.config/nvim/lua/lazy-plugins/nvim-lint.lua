return {
	"mfussenegger/nvim-lint",
	config = function(_, opt)
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			--[[ pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" }, ]]
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
