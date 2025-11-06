return {"akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({

            size = 20,


        })
        local opts = {buffer = 0},
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>")

    end
} 
