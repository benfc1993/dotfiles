local formatters = {
	typescriptreact = "prettierd",
	typescript = "prettierd",
	javascriptreact = "prettierd",
	javascript = "prettierd",
	json = "prettierd",
	html = "prettierd",
	css = "prettierd",
	sass = "prettierd",
	lua = "stylua",
}

local commands = {
	prettier = 'prettier -w "%"',
	prettierd =
	'temp=$(cat "%" | prettierd "%"); if [[ -z $temp  ]]; then exit 0; fi; if  [[ -z $(echo $temp | grep "SyntaxError:")  ]]; then echo $temp > "%"; fi',
	stylua = 'stylua "%"',
}

local CompletionItemKind = {
	"Text",
	"Method",
	"Function",
	"Constructor",
	"Field",
	"Variable",
	"Class",
	"Interface",
	"Module",
	"Property",
	"Unit",
	"Value",
	"Enum",
	"Keyword",
	"Snippet",
	"Color",
	"File",
	"Reference",
	"Folder",
	"EnumMember",
	"Constant",
	"Struct",
	"Event",
	"Operator",
	"TypeParameter",
}

local kind_icons = {
	Text = "󰉿",
	Method = "󰊕",
	Function = "󰊕",
	Constructor = "󰒓",

	Field = "󰜢",
	Variable = "󰆦",
	Property = "󰖷",

	Class = "󱡠",
	Interface = "󱡠",
	Struct = "󱡠",
	Module = "󰅩",

	Unit = "󰪚",
	Value = "󰦨",
	Enum = "󰦨",
	EnumMember = "󰦨",

	Keyword = "󰻾",
	Constant = "󰏿",

	Snippet = "󱄽",
	Color = "󰏘",
	File = "󰈔",
	Reference = "󰬲",
	Folder = "󰉋",
	Event = "󱐋",
	Operator = "󰪚",
	TypeParameter = "󰬛",
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if not client then
			return
		end

		--	if client:supports_method("textDocument/completion") then
		--		local chars = {}
		--		for i = 32, 126 do
		--			table.insert(chars, string.char(i))
		--		end

		--		client.server_capabilities.completionProvider.triggerCharacters = chars

		--		vim.lsp.completion.enable(true, client.id, ev.buf, {
		--			autotrigger = true,
		--			convert = function(item)
		--				return {
		--					abbr = item.label:gsub("%b()", ""),
		--					kind = kind_icons[CompletionItemKind[item.kind]],
		--				}
		--			end,
		--		})
		--	vim.api.nvim_create_autocmd("CompleteChanged", {
		--		buffer = ev.buf,
		--		callback = function()
		--			local info = vim.fn.complete_info()
		--			local selected = info.items[info.selected + 1]

		--			if selected == nil then
		--				return
		--			end

		--			client:request(
		--				"completionItem/resolve",
		--				selected["user_data"].nvim.lsp.completion_item,
		--				function(err, res)
		--					if err ~= nil then
		--						vim.print(err)
		--						return
		--					end

		--					if res == nil then
		--						return
		--					end

		--					local docs = vim.tbl_get(res, "documentation", "value")
		--					local ft = vim.tbl_get(res, "documentation", "kind")

		--					if docs == nil or docs == '' then
		--						docs = vim.tbl_get(res, "detail")
		--						ft = vim.bo.filetype
		--						if ft == "typescriptreact" then ft = 'tsx' end
		--					end

		--					if docs == nil then
		--						return
		--					end

		--					local winData = vim.api.nvim__complete_set(info.selected, { info = docs })
		--					if not winData.winid or not vim.api.nvim_win_is_valid(winData.winid) then
		--						return
		--					end
		--					vim.api.nvim_win_set_config(
		--						winData.winid,
		--						{ border = "single", focusable = true, mouse = true }
		--					)
		--					vim.treesitter.start(winData.bufnr, ft)
		--					vim.api.nvim_win_set_height(
		--						winData.winid,
		--						math.min(
		--							vim.api.nvim_win_get_height(winData.winid),
		--							math.floor(vim.api.nvim_win_get_height(0) / 3)
		--						)
		--					)
		--					vim.api.nvim_win_set_width(
		--						winData.winid,
		--						math.min(
		--							vim.api.nvim_win_get_width(winData.winid),
		--							math.floor(vim.api.nvim_win_get_width(0) / 2)
		--						)
		--					)
		--					vim.wo[winData.winid].conceallevel = 1
		--					vim.wo[winData.winid].wrap = true
		--				end,
		--				ev.buf
		--			)
		--		end,
		--	})
		--end


		--	vim.api.nvim_create_autocmd("BufWritePost", {
		--		callback = function(opts)
		--			local formatter = nil
		--			for ft, fmtr in pairs(formatters) do
		--				if vim.bo[opts.buf].filetype == ft then
		--					formatter = fmtr
		--				end
		--			end

		--			if formatter == nil then
		--				if client:supports_method("textDocument/formatting") then
		--					vim.lsp.buf.format()
		--				end
		--				return
		--			end

		--			local fmt_command = commands[formatter]
		--			vim.cmd("silent !" .. fmt_command)
		--		end,
		--	})
	end,
})

vim.lsp.enable({ "lua_ls", "vtsls", "cssls", "tailwindcss", "graphql", "bashls"})

vim.diagnostic.config({
	signs = {
		severity_sort = true,
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		},
	},
})
