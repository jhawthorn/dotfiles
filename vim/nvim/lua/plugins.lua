return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'nvim-lua/plenary.nvim'

use 'nvim-telescope/telescope.nvim'
use 'nvim-telescope/telescope-fzy-native.nvim'
use 'nvim-treesitter/nvim-treesitter'
use 'jhawthorn/github-coauthors.nvim'
use 'lewis6991/gitsigns.nvim'
use 'feline-nvim/feline.nvim'
use 'jhawthorn/wombat.nvim'
use 'rktjmp/lush.nvim'
use 'kyazdani42/nvim-web-devicons'
use 'akinsho/git-conflict.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'williamboman/mason.nvim'
use 'neovim/nvim-lspconfig'
use 'jose-elias-alvarez/null-ls.nvim'

  use "rafamadriz/friendly-snippets"

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/src", "~/github", "~/Downloads", "/"},
      }
    end
  }
end)
