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

vim.opt.backup = false
vim.opt.swapfile = false

-- persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

vim.opt.virtualedit = 'block'

-- < and > for indentation
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

vim.keymap.set({'n', 'v'}, '<ENTER>', ':')

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

-- system clipboard
vim.keymap.set('v', '<leader>y',   '"+y')
vim.keymap.set('n', '<leader>Y',   '"+yg_')
vim.keymap.set('n', '<leader>y',   '"+y')
vim.keymap.set('n', '<leader>yy',  '"+yy')
vim.keymap.set('n', '<leader>p',   '"+p')
vim.keymap.set('n', '<leader>P',   '"+P')
vim.keymap.set('v', '<leader>p',   '"+p')
vim.keymap.set('v', '<leader>P',   '"+P')

--require('plugins')
require('config.lazy')

vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
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
        fallback()
      end
    end, { "i", "s" }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-c>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
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

-- Make cmp capabilities available to all LSP servers
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = { "inactive-code" }
            }
        }
    }
})

vim.lsp.config('clangd', {})
vim.lsp.config('ruby_lsp', {})

vim.lsp.enable({ 'rust_analyzer', 'clangd', 'ruby_lsp' })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end

    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap({'n', 'x'}, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
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


vim.cmd.colorscheme "catppuccin-mocha"

vim.cmd("autocmd VimResized * wincmd =")

vim.api.nvim_create_user_command("CoAuthor",
  function()
	  require('telescope').extensions.githubcoauthors.coauthors()
  end,
  {})

vim.api.nvim_create_user_command("Blame", "Gitsigns blame", {})

-- vim.cmd("command CoAuthor lua require('telescope').extensions.githubcoauthors.coauthors()<CR>")

