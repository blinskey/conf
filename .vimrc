" Emulate vi when invoked as such.
if v:progname == 'vi'
    set compatible
    set noloadplugins
    set t_Co=0
    set shortmess+=I
    finish
endif

set nocompatible

augroup vimrc
    autocmd!
augroup END

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')
        Plug 'w0rp/ale', {'tag': 'v2.3.1'}
        Plug 'blinskey/btl.vim'
        Plug 'ctrlpvim/ctrlp.vim', {'commit': '2e773fd8'}
        Plug 'editorconfig/editorconfig-vim', {'commit': '68f8136'}
        Plug 'Vimjas/vim-python-pep8-indent', {'commit': '84f35c0'}
        Plug 'cocopon/iceberg.vim', {'commit': '8b5ca00'}
        Plug 'fatih/vim-go', {'commit': 'f040988'}

        " To install fzf, assuming $GOPATH is ~/go:
        "     go get github.com/junegunn/fzf
        "     cd ~/go/src/github.com/junegunn/fzf
        "     make && make install
        if !empty(glob('~/go/src/github.com/junegunn/fzf'))
            Plug '~/go/src/github.com/junegunn/fzf'
            Plug 'junegunn/fzf.vim', {'commit': 'b31512e'}
        endif
    call plug#end()
endif

filetype plugin indent on
silent! packadd! matchit

silent! syntax enable

" Enable Iceberg and make a couple of gray colors lighter to increase contrast.
silent! colorscheme iceberg
hi! Comment ctermfg=245
hi! ColorColumn ctermbg=236

set shortmess+=I  " No intro message on startup.
set encoding=utf-8

" Enable keymap but start in Latin keyboard mode.
silent! set keymap=armenian-western_utf-8
set iminsert=0
set imsearch=0

set nowrap
set textwidth=79
set colorcolumn=80

" See :h fo-table.
set formatoptions-=t
set formatoptions+=cqnl1j

set wildmode=longest,list
set wildignore=*.o,*.obj,*.pyc,*/node_modules/*,*/.git/*
set autoindent
set smarttab
set ignorecase
set smartcase
set autoread
set ruler
set incsearch
set ttimeoutlen=100
set splitright
set splitbelow
set mouse=
set laststatus=2

" Use spaces, not tabs, with four spaces for indentation.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Store swapfiles in ~/tmp/vim.
if !isdirectory($HOME . "/tmp/vim")
    call mkdir($HOME . "/tmp/vim", "p")
endif
set directory=$HOME/tmp/vim

" Filetypes for file extensions
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python

map <leader>e :Explore<cr>
map <leader>s :Sexplore<cr>
map <leader>v :Vexplore<cr>
let g:netrw_banner = 0  " Hide banner.

map <leader><leader> :FZF<cr>

let g:ale_sign_column_always = 1
let g:ale_linters = {'python': ['flake8']}

" Strip trailing whitespace on write, preserving window view.
function! s:StripTrailingWhitespace()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfun
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespace()

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
map! <C-F> <Esc>gUiw`]a

set grepprg=grep\ -riIn\ $*\ /dev/null
