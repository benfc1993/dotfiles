local godot_executable = vim.fn.expand("$HOME") .. "/programs/Godot_4_2_1/Godot_v4.2.1-stable_mono_linux.x86_64"
return {
	"habamax/vim-godot",
	ft = { "gdscript" },
	config = function()
		vim.g.godot_executable = godot_executable
	end,
	keys = {
		{ "<F5>", "<cmd>exec winheight(0)/3.'split'<cr><cmd>term " .. godot_executable .. "<cr>" },
	},
}
