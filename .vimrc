"=== vim-plug =================================================================
" See https://github.com/junegunn/vim-plug

" Try to automatically install plug.vim if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

if !empty(glob('~/.vim/autoload/plug.vim'))
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
    Plug 'kien/ctrlp.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'jiangmiao/auto-pairs'
    Plug 'wesQ3/vim-windowswap'
    "Plug 'vim-scripts/Conque-Shell'
    "Plug 'Shougo/vimshell.vim'
    Plug 'jeetsukumaran/vim-buffergator'
    Plug 'tacahiroy/ctrlp-funky'

    call plug#end()
endif

"=== Appearance ===============================================================

syntax enable
set t_Co=256
set background=dark
silent! colorscheme hybrid

 " Show line numbers
 set number

 " Highlight current line
 set cursorline

 "=== Indentation and tabs =====================================================

 set smartindent
 set tabstop=4
 set softtabstop=4
 set shiftwidth=4
 set expandtab
 filetype indent on

 autocmd Filetype markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

 "=== Search ===================================================================
 set ignorecase
 set smartcase

 "=== Line wrapping ============================================================

 set nowrap
 set textwidth=79

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

"=== Powerline ===============================================================

" Use the Powerline statusline (package "powerline" in Ubuntu).
" See https://github.com/powerline/powerline and powerline.readthedocs.org
if !empty(glob('/usr/share/vim/addons/plugin/powerline.vim'))
    python from powerline.vim import setup as powerline_setup
    python powerline_setup()
    python del powerline_setup

    set laststatus=2 " Always display the statusline in all windows
    set showtabline=2 " Always display the tabline, even if there is only one tab
    set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)"
endif

"=== Miscellaneous ============================================================

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" Use Markdown syntax highlighting for .md files.
au BufRead,BufNewFile *.md set filetype=markdown

" Write with root privileges.
cmap sudow w !sudo tee > /dev/null %

let mapleader=","

"=== ctrlp-funky ==============================================================

nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>


"=== Autocomplete =============================================================

" Based on https://robots.thoughtbot.com/vim-macros-and-you
" See :h ins-completion

imap <Tab> <C-P>

" Populate suggestions from current file, other buffers, and current tags file.
set complete=.,b,u,]

" Replacement settings, similar to zsh defaults.
set wildmode=longest,list:longest

"=== Splits ===================================================================

" Based on https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" See :h splits

" Simple window movement.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new windows to the right and bottom of current window.
set splitbelow
set splitright
