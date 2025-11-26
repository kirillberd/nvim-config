local map = require("helpers.keys").map

-- Quick access to some common actions
map("n", "<leader>fw", "<cmd>w<cr>", "Write")
map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- Window management
map("n", "<leader>sv", "<C-w>v", "Split window vertcally")
map("n", "<leader>sy", "<C-w>s", "Split window horizontally")
map("n", "<leader>se", "<C-w>=", "Make splits equal size")
map("n", "<leader>sx", "<cmd>close<CR>", "Close current split")
map("n", "<leader>sw", "<C-w>w", "Cycle through open windows")
map("n", "<leader>sh", "<C-w>h", "Move to left window")
map("n", "<leader>sj", "<C-w>j", "Move to lower window")
map("n", "<leader>sk", "<C-w>k", "Move to upper window")
map("n", "<leader>sl", "<C-w>l", "Move to right window")

map("n", "<leader>mh", "<C-w>H", "Move split left")
map("n", "<leader>ml", "<C-w>L", "Move split right")

map("n", "<leader>to", "<cmd>tabnew<CR>", "Open new tab")
map("n", "<leader>tx", "<cmd>tabclose<CR>", "Close current tab")
map("n", "<leader>tn", "<cmd>tabn<CR>", "Go to next tab")
map("n", "<leader>tp", "<cmd>tabp<CR>", "Go to previous tab")
map("n", "<leader>tf", "<cmd>tabnew %<CR>", "Open current buffer in new tab")
