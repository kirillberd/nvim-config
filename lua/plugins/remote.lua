return {
	"amitds1997/remote-nvim.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("remote-nvim").setup({
			offline_mode = {
				enabled = true,
				no_github = true,
				-- Add this only if you want to change the path where the Neovim releases are downloaded/located.
				-- Default location is the output of :lua= vim.fn.stdpath("cache") .. "/remote-nvim.nvim/version_cache"
				-- cache_dir = <custom-path>,
				--
			},

			remote = {

				copy_dirs = {
					data = {

						base = vim.fn.stdpath("data"),
						dirs = "*",
						compression = {
							enabled = true,
							additional_opts = { "--exclude='jdtls-workspace'" },
						},
					},
					config = {
						base = vim.fn.stdpath("config"),
						dirs = "*",
						compression = {
							enabled = true,
							additional_opts = { "--exclude='.git'" },
						},
					},
				},
			},
		})
	end,
}
