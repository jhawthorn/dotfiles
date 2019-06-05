set nocompatible
filetype off

let mapleader=" "

" vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" <3 TPOPE!
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-dispatch'

Plugin 'vim-ruby/vim-ruby'

Plugin 'bronson/vim-trailing-whitespace'

" CamelCase and underscored words
Plugin 'camelcasemotion'

Plugin 'godlygeek/tabular'
if exists(":Tabularize")
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:\zs<CR>
	vmap <Leader>a: :Tabularize /:\zs<CR>
endif

Plugin 'file-line'

" version control
Plugin 'int3/vim-extradite'
let g:extradite_showhash=1

Plugin 'airblade/vim-gitgutter'

"" color scheme
Plugin 'wombat256.vim'

" tab completion
Plugin 'ervandew/supertab'

" Additional filetypes
Plugin 'JSON.vim'
Plugin 'tpope/vim-markdown'

" Safe escaping of pastes
Plugin 'ConradIrwin/vim-bracketed-paste'


call vundle#end()

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
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType elixir setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab

  "autocmd User Rails let  g:fuzzy_roots = [RailsRoot()]

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
"set list
"set listchars=tab:·\ ,trail:·,extends:»,precedes:« "

set nobackup
set noswapfile
set fileencodings=ucs-bom,utf-8,latin1

set virtualedit=block

" I don't use this, but the default cipher is broken
if v:version > 704 || v:version ==704 && has("patch399")
	set cryptmethod=blowfish2
end

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


" Start and end of line
nnoremap H ^
vnoremap H ^
nnoremap L g_
vnoremap L g_

" arrows control indentation
vnoremap <silent>< <gv
vnoremap <silent>> >gv

nnoremap <C-\> :Ag "\b<cword>\b"<CR>

nnoremap <ENTER> :
vnoremap <ENTER> :

" Evil screen/tmux steals my beloved C-a
nnoremap <leader>a <C-a>
nnoremap <leader>x <C-x>

" okay, tmux might be awesome
Plugin 'christoomey/vim-tmux-navigator'


nnoremap <leader><backspace> :Dispatch<CR>
nnoremap <leader><insert> :execute('Start bundle exec rspec %:' . line('.'))<CR>
nnoremap <leader><delete> :Start<CR>

let g:projectiles = {
      \   'Gemfile' : {
      \     '*_spec.rb' : {
      \       'dispatch': "bundle exec rspec {file}",
      \       'make' : "bundle exec rspec spec",
      \       'start' : "bundle exec rspec rspec {file}"
      \     },
      \     'spec/*_spec.rb' : {
      \       'template' : "require 'spec_helper'\n\ndescribe {camelcase|colons} do\n\nend",
      \       'type' : 'spec',
      \     },
      \     'app/models/*.rb' : {
      \       'alternate' : 'spec/models/{}_spec.rb',
      \       'type' : 'model',
      \       'template' : "class {camelcase|colons} < ActiveRecord::Base\nend"
      \     },
      \     'app/controllers/*.rb' : {
      \       'alternate' : 'spec/controllers/{}_spec.rb',
      \       'type' : 'controller',
      \       'template' : "class {camelcase|colons} < ApplicationController\nend"
      \     },
      \     'spec/models/*_spec.rb' : {
      \       'alternate' : 'app/models/{}.rb',
      \     },
      \     'spec/controllers/*_spec.rb' : {
      \       'alternate' : 'app/controllers/{}.rb',
      \     },
      \     'spec/lib/*_spec.rb' : {
      \       'alternate' : 'lib/{}.rb',
      \     },
      \     'lib/*.rb' : {
      \       'alternate' : 'spec/lib/{}_spec.rb',
      \       'type' : 'lib',
      \       'template' : "class {camelcase|colons}\nend"
      \     }
      \   }
      \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

map <leader>ph :r!tail -n20 /home/jhawthorn/.pry_history\|tac\|fzy<CR>

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e       :call FzyCommand('ag . -l -g ""', ":e")<cr>
nnoremap <leader>v       :call FzyCommand('ag . -l -g ""', ":vs")<cr>
nnoremap <leader>s       :call FzyCommand('ag . -l -g ""', ":sp")<cr>
nnoremap <leader><space> :call FzyCommand('ag . -l -g ""', ":sp")<cr>

nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

