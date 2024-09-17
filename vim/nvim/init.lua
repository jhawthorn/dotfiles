-- set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- let &packpath = &runtimepath
-- source ~/.vimrc

-- set wildmode=list:longest,full

-- " Timely updates from gitgutter
-- set updatetime=100

-- supposedly not supposed to be set by default (anymore?)
-- set lazyredraw

vim.cmd('iab xdate <c-r>=strftime("%Y-%m-%d")<cr>')

vim.g.mapleader = ' '

vim.opt.shortmess = 'atI'
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.scrolloff = 10

-- might be better to do detection
vim.o.termguicolors = true

vim.keymap.set({'n', 'i'}, "<F1>", "<ESC>")
-- vim.keymap.del({'n'}, "<F1>")

vim.keymap.set('v', '<silent><', '<gv')
vim.keymap.set('v', '<silent>>', '>gv')

vim.g.nobackup = true
vim.g.noswapfile = true

vim.g.virtualedit = 'block'

-- < and > for indentation
vim.keymap.set('v', '<silent><', '<gv')
vim.keymap.set('v', '<silent>>', '>gv')

vim.keymap.set({'n', 'v'}, '<ENTER>', ':')
vim.keymap.set('v', '<ENTER>', ':')

vim.cmd("autocmd BufReadPost quickfix nnoremap <buffer> <ENTER> <ENTER>")

vim.keymap.set('n', '<leader><space>', ':Telescope find_files prompt_prefix=\\ \\ <cr>')
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>g', ':Telescope treesitter<cr>')
vim.keymap.set('n', '<leader>:', ':Telescope command_history<cr>')

vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')

vim.keymap.set('n', '<leader>a', '<C-a>')
vim.keymap.set('n', '<leader>x', '<C-x>')

--require('plugins')
require('config.lazy')

vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() ~= nil then
        cmp.confirm({ select = true })
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-c>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["vsnip#jumpable"](1) == 1 then
        feedkey("<Plug>(vsnip-jump-next)", "")
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'zsh' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}
local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

require("lspconfig").rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = { "inactive-code" }
            }
        }
    }
}

require("lspconfig").clangd.setup {}

require("lspconfig").ruby_lsp.setup{}

-- require("lspconfig").rubocop.setup{}

vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    --bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    --bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
---- swapping buffers between windows
--vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
--vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
--vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
--vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

vim.cmd("let g:vsnip_filetypes = {}")
vim.cmd("let g:vsnip_filetypes.ruby = ['rails']")
vim.cmd("let g:vsnip_filetypes.cruby = ['c']")

vim.cmd.colorscheme "catppuccin-mocha"

vim.cmd("autocmd VimResized * wincmd =")

vim.api.nvim_create_user_command("CoAuthor",
  function()
	  require('telescope').extensions.githubcoauthors.coauthors()
  end,
  {})

vim.api.nvim_create_user_command("Blame", "Gitsigns blame", {})

-- vim.cmd("command CoAuthor lua require('telescope').extensions.githubcoauthors.coauthors()<CR>")

