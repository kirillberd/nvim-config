return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mfussenegger/nvim-jdtls",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"basedpyright",
				"jdtls",
				"gradle_ls",
			},
			automatic_enable = {
				exclude = {
					"jdtls",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- linters
				"prettier",
				"stylua",
				"black",
				"pylint",
				"checkstyle",
				"google-java-format",
			},
		})
	end,
}
