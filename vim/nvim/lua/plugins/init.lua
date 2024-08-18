return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	'nvim-telescope/telescope-fzy-native.nvim',
	'jhawthorn/github-coauthors.nvim',

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "ruby", "c", "lua", "rust", "python", "markdown", "make", "go", "cpp", "bash" },
			})
		end,
	},

	-- cmd and vsnip
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',

	-- git extras
	'lewis6991/gitsigns.nvim',
	'akinsho/git-conflict.nvim',

	-- 
	--use 'kyazdani42/nvim-web-devicons'
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup {
				options = { theme = 'wombat', }
			}
		end
	},

	-- theme
	'rktjmp/lush.nvim',
	'jhawthorn/wombat.nvim',

	-- LSP
        'williamboman/mason-lspconfig.nvim',
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
        'jose-elias-alvarez/null-ls.nvim',

	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			require('smart-splits').setup({
				at_edge = 'none',
			})
		end
	},
}
