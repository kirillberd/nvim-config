return {
	"saghen/blink.cmp",
	-- blink handles lazy loading internally, no event needed
	version = "1.*", -- use a release tag to get prebuilt fuzzy-matcher binaries
	dependencies = {
		"rafamadriz/friendly-snippets", -- useful snippets
	},
	opts = {
		keymap = {
			preset = "default",
			-- accept selected item, or the first one if nothing is selected
			["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
			["<Esc>"] = { "cancel", "fallback" },
		},
		completion = {
			list = {
				-- don't preselect, insert text while navigating with Up/Down
				selection = { preselect = false, auto_insert = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority
					score_offset = 100,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
