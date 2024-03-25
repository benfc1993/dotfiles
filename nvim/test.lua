local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local example = function(opts)
	opts = opts or {}
	pickers
		.new({}, {
			prompt_title = "config file",
			finder = finders.new_oneshot_job({ "find", ".", "-name", "jest.*.config.ts", "-type", "f" }, {}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function()
				actions.select_default:replace(function(prompt_buf)
					actions.close(prompt_buf)
					local selection = action_state.get_selected_entry()
					print(vim.fs.basename(vim.inspect(selection[1])))
				end)
				return true
			end,
		})
		:find()
end

example()
