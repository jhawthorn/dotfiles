set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set termguicolors

lua <<EOF

local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.load_extension('githubcoauthors')

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "ruby", "c", "lua", "rust", "python", "markdown", "make", "go", "cpp", "bash" },
}

require('gitsigns').setup()

require('feline').setup()

EOF

colorscheme wombat_lush

command CoAuthor lua require('telescope').extensions.githubcoauthors.coauthors()<CR>
