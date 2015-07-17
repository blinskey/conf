"=== Vundle ===================================================================
"
" See https://github.com/VundleVim/Vundle.vim or ":h vundle" for details.

" The following two settings are required.
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'gmarik/Vundle.vim' " Required

Plugin 'tpope/vim-afterimage'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-characterize'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" All of your plugins must be added before the following line.
call vundle#end() " Required

filetype plugin indent on " Required

" To ignore plugin indent changes, instead use:
"filetype plugin on

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

