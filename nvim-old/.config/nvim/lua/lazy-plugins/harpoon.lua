return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	name = "harpoon",

	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED
		-- set keymaps

		nmap("<leader>a", function()
			harpoon:list():add()
		end, "[Harpoon] Add to list")
		nmap("<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, "[Harpoon] Add to list")
		nmap("<C-s>", function()
			harpoon:list():prev()
		end)
		nmap("<C-f>", function()
			harpoon:list():next()
		end)
		-- nmap("<C-i>", function()
		-- 	harpoon:list():prev()
		-- end, "[Harpoon] Add to list")
		-- nmap("<C-o>", function()
		-- 	harpoon:list():next()
		-- end, "[Harpoon] Add to list")

		-- 	-- basic telescope configuration
		-- 	local conf = require("telescope.config").values
		-- 	local function toggle_telescope(harpoon_files)
		-- 		local file_paths = {}
		-- 		for _, item in ipairs(harpoon_files.items) do
		-- 			table.insert(file_paths, item.value)
		-- 		end
		--
		-- 		require("telescope.pickers")
		-- 			.new({}, {
		-- 				prompt_title = "Harpoon",
		-- 				finder = require("telescope.finders").new_table({
		-- 					results = file_paths,
		-- 				}),
		-- 				previewer = conf.file_previewer({}),
		-- 				sorter = conf.generic_sorter({}),
		-- 			})
		-- 			:find()
		-- 	end
		--
		-- 	vim.keymap.set("n", "<C-e>", function()
		-- 		toggle_telescope(harpoon:list())
		-- 	end, { desc = "Open harpoon window" })
	end,
}
