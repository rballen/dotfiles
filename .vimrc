" rballen's .vimrc file

" Config {{{
set shell=/bin/bash
set backspace=indent,eol,start  " make that backspace key work the way itshould
set noswapfile                  " Disable swap files
set nobackup			        " Turn off automatic backups (~files)
set nowritebackup
set nocompatible
" }}}


" UI {{{
set encoding=utf-8
set number			            " Turn on line numbering
set nowrap                      " Line wrapping off
set ai                          " set auto-indenting on for programming
set showmode                    " show the editing mode on the last line
set showmatch                   " automatically show matching brackets
set cursorline                 " Highlight current line
set cmdheight=1                 " Make the command area two lines high
" }}}

" Colors Settings {{{
colorscheme heroku              "  heroku dracula  toychest
syntax on                       " enable syntax highlighting
set background=dark             " Use colours that work well on a dark background (Console is usually black)
" set t_Co=256			        " Set terminal colors to 256
" }}}



" Behaviors {{{
set hidden                      " Change buffer - without saving
set iskeyword+=$,@,-            " Add extra characters that are valid parts of variables
" }}}


" Text Format {{{
set tabstop=3			        " Columns per tab
set shiftwidth=3		        " Columns per autoindent
set expandtab
set softtabstop=3
" }}}


" Searching {{{
set ignorecase                  " make searches case insensitive
set smartcase                   " Non-case sensitive search
set hlsearch                    " highlight matching search strings
set wildignore+=.final_builds/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,*/Godeps/*
set gdefault                    " Enable the g flag by default when substituting
set incsearch                   " Find the next match as we type the search
" }}}


" Sounds {{{
set noerrorbells
set novisualbell
" }}}


call plug#begin('~/.vim/plugins_by_vimplug')

Plug  'vim-scripts/CycleColor'

Plug 'mattn/emmet-vim'

" git wrapper 
Plug 'tpope/vim-fugitive'      

Plug 'tpope/vim-git'    " git syntax highlighter

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } 

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

call plug#end()


let mapleader=','            " Map leader to ,

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

