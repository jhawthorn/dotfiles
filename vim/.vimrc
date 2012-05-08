set nocompatible
filetype off

" vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" TPOPE!
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-afterimage'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'

" Statusbar
Bundle 'Lokaltog/vim-powerline'
if has("gui_running")
	let g:Powerline_symbols = 'fancy'
else
	"let g:Powerline_symbols = 'unicode'
	let g:Powerline_symbols = 'compatible'
endif
let g:Powerline_symbols_override = { 'BRANCH': [0x26a1], 'LINE': 'L', }

" syntastic
Bundle 'scrooloose/syntastic.git'

Bundle 'tsaleh/vim-align'
Bundle "file-line"

" version control
Bundle 'vcscommand.vim'
Bundle 'int3/vim-extradite'

"" LaTeX
"Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" color scheme
Bundle 'wombat256.vim'
set cursorline

" tab completion
Bundle 'ervandew/supertab'

" Additional filetypes
Bundle 'JSON.vim'
Bundle 'Neurogami/mirah-vim'

"Bundle 'skammer/vim-css-color'

Bundle 'ack.vim'

" ctrlp
"Bundle 'kien/ctrlp.vim'
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so
"let g:ctrlp_user_command = 'find %s -type f'


filetype plugin indent on

if has("gui_running")
	set guioptions=
	set guifont=Terminus\ 10
endif

set wildmenu
set wildmode=list:longest,full

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set laststatus=2

set ffs=unix,mac,dos


set tabstop=3
set shiftwidth=3
set noexpandtab

if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType haml setlocal ts=2 sts=2 sw=2 expandtab

  autocmd User Rails let  g:fuzzy_roots = [RailsRoot()]

  " File types
  au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} setfiletype ruby
  au BufRead,BufNewFile {*.rss,*.atom}                              setfiletype xml
  au BufRead,BufNewFile *.json                                      setfiletype json
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                     setfiletype markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG}                            setfiletype gitcommit
  au BufRead,BufNewFile *mutt-*                                     setfiletype mail
  au BufRead,BufNewFile svn-commit.*                                setfiletype svn
  au BufRead,BufNewFile *.vala                                      setfiletype vala
  au BufRead,BufNewFile *.vapi                                      setfiletype vala

  au BufRead,BufNewFile *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
  au BufRead,BufNewFile *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m

  au BufRead,BufNewFile pos.*.* setfiletype basic
  au BufRead,BufNewFile *.mirah setfiletype mirah
endif

set shell=zsh
set shortmess=atI

set ttyfast
set t_Co=256
set noerrorbells
set novisualbell
set lazyredraw

" Extremely fast timeout for escape codes
" Gets us in normal mode fast
" Might mess with some keybindings
set timeoutlen=1000
set ttimeoutlen=0
"set noesckeys


syntax on

iab xdate <c-r>=strftime("%Y-%m-%d")<cr>

set backspace=indent,eol,start

set number
set mouse=
set tf
set showcmd

set hlsearch
set incsearch
nmap \/ :noh<CR>

" <PageUp> and <PageDown> do silly things in normal mode with folds
noremap <PageUp> <C-u>
noremap <PageDown> <C-d>

" don't accidentally open help
nmap <F1> <Esc>
map! <F1> <Esc>

" unprintable characters
set nolist " off by default
set listchars=tab:·\ ,eol:¶,trail:·,extends:»,precedes:« "

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set nobackup
set noswapfile
set fileencodings=ucs-bom,utf-8,latin1

" persistent undo
set undodir=~/.vim/backups
set undofile


" Sudo write
cmap w!! w !sudo tee % >/dev/null

set ignorecase smartcase

" use very magic 
nnoremap / /\v
vnoremap / /\v
cnoremap '<,'>s/ '<,'>s/\v
cnoremap '<,'>s# '<,'>s#\v
cnoremap '<,'>s@ '<,'>s@\v
cnoremap %s/ %s/\v
cnoremap %s# %s#\v
cnoremap %s@ %s@\v
cnoremap s/ s/\v
cnoremap s# s#\v
cnoremap s@ s@\v'

set background=dark
colorscheme wombat256mod

