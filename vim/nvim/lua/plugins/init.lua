return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim',
			'jhawthorn/github-coauthors.nvim',
		},
		config = function() 
			local telescope = require('telescope')
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
			})
			telescope.load_extension('fzy_native')
			telescope.load_extension('githubcoauthors')
		end,
	},

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
	{
		'lewis6991/gitsigns.nvim',
		opts = {},
	},
	{
		'akinsho/git-conflict.nvim',
		opts = {
			default_mappings = true,
			disable_diagnostics = false,
		},
	},

	-- 
	--use 'kyazdani42/nvim-web-devicons'
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = { theme = 'wombat', },
		},
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
		opts = {
			at_edge = 'stop',
		},
	},
}
