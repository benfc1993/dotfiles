local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local make_entry = require("telescope.make_entry")
local themes = require("telescope.themes")

-- return require("telescope").register_extension({
-- 	exports = {
-- 		todo = function(opts)
-- 			opts = themes.get_dropdown({ enable_preview = true })
-- 			opts.cwd = opts.cwd or vim.fn.getcwd()
--
-- 			local command = { "rg", "--vimgrep", "-H", "TODO:" }
--
-- 			local seen = {}
-- 			local string_entry_maker = make_entry.gen_from_string()
-- 			opts.entry_maker = function(string)
-- 				if not seen[string] then
-- 					seen[string] = true
-- 					return string_entry_maker(string)
-- 				else
-- 					return nil
-- 				end
-- 			end
--
-- 			pickers
-- 				.new(opts, {
-- 					prompt_title = "TODOs",
-- 					finder = finders.new_oneshot_job(command, opts),
-- 					sorter = sorters.get_generic_fuzzy_sorter(),
-- 					attach_mappings = function(prompt_bufnr)
-- 						actions.select_default:replace(function()
-- 							actions.close(prompt_bufnr)
--
-- 							local selection = action_state.get_selected_entry()
-- 							print(vim.inspect(selection))
-- 							local destination = {}
-- 							local idx = 0
-- 							for match in selection[1]:gmatch("(.-):") do
-- 								table.insert(destination, match)
-- 								idx = idx + 1
--
-- 								if idx == 2 then
-- 									break
-- 								end
-- 							end
-- 							vim.cmd("e " .. table.concat(destination, "|"))
-- 						end)
--
-- 						return true
-- 					end,
-- 				})
-- 				:find()
-- 		end,
-- 	},
-- })
