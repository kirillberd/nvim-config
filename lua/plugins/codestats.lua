return {
	"gisketch/triforce.nvim",
	dependencies = {
		"nvzone/volt",
	},
	config = function()
		require("triforce").setup({
			keymap = {
				show_profile = "<leader>cs", -- Open profile with <leader>tp
			},
		})
	end,
}
