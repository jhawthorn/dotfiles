return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
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
			telescope.load_extension('ui-select')
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "ruby", "c", "lua", "rust", "python", "markdown", "make", "go", "cpp", "bash" },
			endwise = { enable = true },
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
		dependencies = {
			{ 'RRethy/nvim-treesitter-endwise' },
		}
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
		'tpope/vim-fugitive'
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
		},
	},
	{
		'akinsho/git-conflict.nvim',
		opts = {
			default_mappings = true,
			disable_diagnostics = false,
		},
	},

	--use 'kyazdani42/nvim-web-devicons'
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				theme = 'catppuccin',
				disabled_filetypes = {
					'OverseerList',
				},
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {
					-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
					{ 'b:gitsigns_head', icon = ''},
					'diagnostics'
				},
				lualine_c = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", path = 1, },
				},
				lualine_x = {
					--'encoding',
					--'fileformat',
					"overseer",
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
		},
	},

	-- theme
	'rktjmp/lush.nvim',
	'jhawthorn/wombat.nvim',

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,

			color_overrides = {
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				mason = true,
				neotest = true,
				overseer = true,
				telescope = true,
				treesitter = true,
			}
		}

	},

	-- LSP
	{
		'williamboman/mason.nvim',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {
			ensure_installed = { "rust_analyzer" }
		},
		dependencies = { 'williamboman/mason.nvim' }
	},

        'neovim/nvim-lspconfig',
        'jose-elias-alvarez/null-ls.nvim',

	{
		'mrjones2014/smart-splits.nvim',
		opts = {
			at_edge = 'stop',
		},
	},

	'wsdjeg/vim-fetch',

	{
		"nvim-neotest/neotest",
		--optional = true,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			"jhawthorn/neotest-minitest",
			"olimorris/neotest-rspec",

			"stevearc/overseer.nvim",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-minitest"),
					--require("neotest-rspec"),
				},
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				log_level = vim.log.levels.DEBUG
			})
		end,
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
			{ "<leader>ta", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Project Tests" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
			{ "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
		}
	},

	"https://github.com/rhysd/committia.vim",

	{
		'stevearc/overseer.nvim',
		config = function(_, opts)
			require("overseer").setup(opts)

			vim.api.nvim_create_user_command('Bundle', function (args)
				-- TODO: update and other commands
				require("overseer").run_template({
					name = "bundle install"
				})
			end, { desc = "Run bundle install" })

			vim.api.nvim_create_user_command('BundleUpdate', function (args)
				-- TODO: take args from command
				require("overseer").run_template({
					name = "bundle update",
					prompt = "always"
				})
			end, { desc = "Run bundle update" })
		end,
		opts = {
			task_list = {
				bindings = {
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
					["<C-l>"] = false,
					["<PageUp>"] = "ScrollOutputUp",
					["<PageDown>"] = "ScrollOutputDown",
				},
			},
			templates = {
				"builtin",
				"ruby",
			},
		},
		keys = {
			{ "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Open overseer" },
			{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run a command with overseer" },
		}
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏", -- slightly narrower
				-- char = "│", -- center, narrow
			},
		},
	},

	{
		'nmac427/guess-indent.nvim',
		opts = {},
	},
	'tpope/vim-unimpaired',

	-- pretty quickfix
	{
		'yorickpeterse/nvim-pqf',
		config = true
	},

	{
		"folke/trouble.nvim",
		opts = {},
	},
}
