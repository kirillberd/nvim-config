vim.g.mapleader = " "

local keymap = vim.keymap 


-- pressing jk in input mode will work the same as escape  
keymap.set("i", "jk", "<ESC>")

-- pressing space and nh will clear command line
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- deleting single character without copying it
keymap.set("n", "x", '"_x"')

-- split window vertically
keymap.set("n", "<leader>sv", "<C-w>v")
-- split window horizontally
keymap.set("n", "<leader>sh", "<C-w>s")
-- make split windows equal width
keymap.set("n", "<leader>se", "<C-w>=")
-- close current split window
keymap.set("n", "<leader>sx", ":close<CR>")

-- open new tab
keymap.set("n", "<leader>to", ":tabnew<CR>")
-- close current tab
keymap.set("n", "<leader>tx", ":tabclose<CR>")
-- go to next tab
keymap.set("n", "<leader>tn", ":tabn<CR>")
-- go to previous tab
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- to open nvimtree 
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- toggleterm


-- move out of terminal while still keeping it open
keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
-- toggle terminal keymap
keymap.set('n', '<leader>te', '<cmd>ToggleTerm<cr>')
