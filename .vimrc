"=== vim-plug =================================================================
" See https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-afterimage'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-characterize'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

"=== Appearance ===============================================================

syntax enable
set t_Co=256
colorscheme Tomorrow-Night 

" Show line numbers
" set number

"=== Indentation and tabs =====================================================

set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
filetype indent on

"=== Search ===================================================================
set ignorecase
set smartcase

"=== Line wrapping ============================================================

set wrap
set textwidth=80

"=== Miscellaneous ============================================================

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" Use Markdown syntax highlighting for .md files.
au BufRead,BufNewFile *.md set filetype=markdown

