-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
    use("wbthomason/packer.nvim")
    -- lua functions that many plugins use
    use("nvim-lua/plenary.nvim")
  --colorschemes
    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")
    use("ellisonleao/gruvbox.nvim")
    use("neanias/everforest-nvim")
    use("xero/miasma.nvim")
    use("AlexvZyl/nordic.nvim")
    -- tmux and split window navigation
    use("christoomey/vim-tmux-navigator")
    -- maximizes and restores current window
    use("szw/vim-maximizer")
    -- add extra editing features
    -- commenting with gc
    use("numtostr/comment.nvim")
    -- file explorer, need to dowload nerd fonts to display incons
    use("nvim-tree/nvim-tree.lua")
    -- cool icons for nvim-tree
    use("kyazdani42/nvim-web-devicons")
    -- plugin for status line
    use("nvim-lualine/lualine.nvim")
    -- to find files easier
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
    -- autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")  
    use("hrsh7th/cmp-path")  
    
    --snippets
    use("l3mon4d3/luasnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    -- lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- configuring lps servers
    use("neovim/nvim-lspconfig")
    -- for lsp servers autocompletion
    use("hrsh7th/cmp-nvim-lsp")
    -- enchanced lsp uis
    use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })
    -- vcode-like icons for autocompletion
    use("onsails/lspkind.nvim") 
    -- for latex
    use("lervag/vimtex")
    -- toggle terminal in vim
    use("akinsho/toggleterm.nvim")
    -- auto brackets and quotes close
    use("m4xshen/autoclose.nvim")
    -- cheatsheet
    use {
  'sudormrfbin/cheatsheet.nvim',
  requires = {
    {'nvim-telescope/telescope.nvim'},
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
  }
    }
  if packer_bootstrap then
    require("packer").sync()
  end
end)


