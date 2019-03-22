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
        Plug 'w0rp/ale', { 'tag': 'v2.3.1' }
        Plug 'blinskey/btl.vim'
        Plug 'ctrlpvim/ctrlp.vim', { 'commit': '2e773fd8' }
        Plug 'editorconfig/editorconfig-vim', { 'commit': '68f8136' }
        Plug 'Vimjas/vim-python-pep8-indent', { 'commit': '84f35c0' }
    call plug#end()
endif

filetype plugin indent on
silent! packadd! matchit

silent! syntax enable
silent! colorscheme btl

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

" Filetypes for file extensions
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python

map <leader>e :Explore<cr>
map <leader>s :Sexplore<cr>
map <leader>v :Vexplore<cr>
let g:netrw_banner = 0  " Hide banner.

let g:ctrlp_map='<leader><leader>'
let g:ctrlp_max_files = 10000
nnoremap <leader>c :CtrlPClearCache<CR>

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
