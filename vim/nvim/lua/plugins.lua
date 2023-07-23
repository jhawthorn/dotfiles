vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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
  use 'akinsho/git-conflict.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'wombat',
        }
      }
    end
  }
  use 'rktjmp/lush.nvim'
  use 'jhawthorn/wombat.nvim'

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
