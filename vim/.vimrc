set nocompatible
filetype off

let mapleader=","

" vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" <3 TPOPE!
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
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'

Bundle 'vim-ruby/vim-ruby'

Bundle 'bronson/vim-trailing-whitespace'

" syntastic
"Bundle 'scrooloose/syntastic'

" CamelCase and underscored words
Bundle 'camelcasemotion'

Bundle 'godlygeek/tabular'
let mapleader=','
if exists(":Tabularize")
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:\zs<CR>
	vmap <Leader>a: :Tabularize /:\zs<CR>
endif

Bundle "file-line"

" version control
Bundle 'int3/vim-extradite'
let g:extradite_showhash=1

Bundle 'kien/ctrlp.vim'

"Bundle 'airblade/vim-gitgutter'

Bundle 'bling/vim-airline'
let g:airline_theme='badwolf'
let g:airline_powerline_fonts=1

" Fix slow return to normal mode when using powerline
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

"" color scheme
Bundle 'wombat256.vim'

" tab completion
Bundle 'ervandew/supertab'

" Additional filetypes
Bundle 'JSON.vim'
Bundle 'Neurogami/mirah-vim'
Bundle 'jayferd/ragel.vim'
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'

Bundle 'rking/ag.vim'

runtime macros/matchit.vim


filetype plugin indent on

if has("gui_running")
	set guioptions=
	set guifont=Terminus\ 10
endif

set wildmenu
set wildmode=list:longest,full

"set undodir=~/.vim/undo
"set undofile
"set undolevels=1000
"set undoreload=10000

set laststatus=2

set ffs=unix,mac,dos

set foldmethod=manual

if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType eruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType haml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

  autocmd User Rails let  g:fuzzy_roots = [RailsRoot()]

  " File types
  au BufRead,BufNewFile {*.txt}                              set ft=txt
  au BufRead,BufNewFile {*.rake,*.ruby,config.ru}            set ft=ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Guardfile} set ft=ruby
  au BufRead,BufNewFile {*.rss,*.atom}                       set ft=xml
  au BufRead,BufNewFile *.json                               set ft=json
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}              set ft=markdown
  au BufRead,BufNewFile {COMMIT_EDITMSG}                     set ft=gitcommit
  au BufRead,BufNewFile *mutt-*                              set ft=mail formatoptions=aw
  au BufRead,BufNewFile svn-commit.*                         set ft=svn
  au BufRead,BufNewFile {*.vala,*.vapi}                      set ft=vala
  au BufRead,BufNewFile pos.*.*                              set ft=basic
  au BufRead,BufNewFile *.mirah                              set ft=mirah
  au BufRead,BufNewFile *.rl                                 set ft=ragel cindent

  au BufRead,BufNewFile *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
  au BufRead,BufNewFile *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m

  au BufRead,BufNewFile *_spec.rb compiler rspec
endif

set shell=zsh
set shortmess=atI

"set t_Co=256
set noerrorbells
set novisualbell
set ttyfast
set lazyredraw

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

set virtualedit=block

" Sudo write
cmap w!! w !sudo tee % >/dev/null

set ignorecase smartcase

set background=dark
if filereadable(expand("~/.vim/bundle/wombat256.vim/colors/wombat256mod.vim"))
	colorscheme wombat256mod
end

" save ~100ms loading ftplugin/ruby.vim
if !empty($MY_RUBY_HOME)
	let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif

:command -nargs=* Make silent make <args> | cwindow 10 | redraw!
nmap <leader>t :wa<cr>:Make %<cr>

" arrows control indentation
vnoremap <silent>< <gv
vnoremap <silent>> >gv

nnoremap <C-\> :Ag "\b<cword>\b"<CR>

nnoremap <ENTER> :
vnoremap <ENTER> :
