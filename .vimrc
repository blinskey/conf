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
"Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-git'
Plug 'crusoexia/vim-monokai'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

"=== Appearance ===============================================================

syntax enable
set t_Co=256
colorscheme monokai

" Show line numbers
set number

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

" Draw ruler at column 80.
" From http://stackoverflow.com/a/3765575/2530735
if exists('+colorcolumn')
  set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"=== Whitespace ===============================================================

" Strip trailing whitespace on save.
" From http://stackoverflow.com/a/1618401/2530735
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"=== Miscellaneous ============================================================

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" Use Markdown syntax highlighting for .md files.
au BufRead,BufNewFile *.md set filetype=markdown

" Write with root privileges.
cmap sudow w !sudo tee > /dev/null %

