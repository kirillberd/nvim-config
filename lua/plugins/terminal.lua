return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({

			size = 20,
		})
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>")
	end,
}
