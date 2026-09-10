return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
		},
		config = function()
			local ensure_installed = { "lua", "java", "python", "vimdoc", "vim" }
			require("nvim-treesitter").install(ensure_installed)

			-- highlight + indent are now enabled per buffer
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterSetup", {}),
				callback = function(ev)
					if not pcall(vim.treesitter.start, ev.buf) then
						return -- no parser for this filetype
					end
					if vim.bo[ev.buf].filetype ~= "python" then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- incremental selection: removed from the plugin, minimal replacement
			local sel_stack = {}

			local function select_node(node)
				local sr, sc, er, ec = node:range()
				if ec == 0 then
					er = er - 1
					ec = math.max(#vim.fn.getline(er + 1), 1)
				end
				local mode = vim.api.nvim_get_mode().mode
				if mode ~= "n" then
					vim.cmd("normal! \27") -- leave visual so gv picks up the new marks
				end
				vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
				vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
				vim.cmd("normal! gv")
			end

			local function init_or_expand()
				local buf = vim.api.nvim_get_current_buf()
				local in_visual = vim.api.nvim_get_mode().mode:match("[vV\22]")
				local stack = in_visual and sel_stack[buf] or nil
				if not stack or #stack == 0 then
					local node = vim.treesitter.get_node()
					if not node then
						return
					end
					sel_stack[buf] = { node }
					select_node(node)
					return
				end
				-- expand to the nearest parent with a bigger range
				local cur = stack[#stack]
				local csr, csc, cer, cec = cur:range()
				local parent = cur:parent()
				while parent do
					local psr, psc, per, pec = parent:range()
					if psr ~= csr or psc ~= csc or per ~= cer or pec ~= cec then
						break
					end
					parent = parent:parent()
				end
				if parent then
					table.insert(stack, parent)
					select_node(parent)
				end
			end

			local function shrink()
				local buf = vim.api.nvim_get_current_buf()
				local stack = sel_stack[buf]
				if stack and #stack > 1 then
					table.remove(stack)
					select_node(stack[#stack])
				end
			end

			vim.keymap.set({ "n", "x" }, "<C-Space>", init_or_expand, { desc = "Incremental selection" })
			vim.keymap.set("x", "<C-BS>", shrink, { desc = "Shrink selection" })

			-- textobjects
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true }, -- automatically jump forward to textobj, similar to targets.vim
				move = { set_jumps = true }, -- whether to set jumps in the jumplist
			})

			local ts_select = require("nvim-treesitter-textobjects.select")
			for lhs, query in pairs({
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					ts_select.select_textobject(query, "textobjects")
				end)
			end

			local ts_move = require("nvim-treesitter-textobjects.move")
			for fn, mappings in pairs({
				goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
				goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
				goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
				goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
			}) do
				for lhs, query in pairs(mappings) do
					vim.keymap.set({ "n", "x", "o" }, lhs, function()
						ts_move[fn](query, "textobjects")
					end)
				end
			end
		end,
	},
}
