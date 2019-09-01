" Emulate vi when invoked as such.
if v:progname == 'vi'
    set compatible
    set noloadplugins
    set t_Co=0
    set shortmess+=I
    syntax off
    finish
endif

set nocompatible
set secure
set nomodeline

augroup vimrc
    autocmd!
augroup END

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')
        " Use the local development copy of my colorscheme if present.
        if !empty(glob('~/src/btl.vim'))
            Plug '~/src/btl.vim'
        else
            Plug 'blinskey/btl.vim'
        endif

        Plug 'w0rp/ale', {'tag': 'v2.3.1'}
        Plug 'editorconfig/editorconfig-vim', {'commit': '68f8136'}
        Plug 'Vimjas/vim-python-pep8-indent', {'commit': '84f35c0'}
        Plug 'cocopon/iceberg.vim', {'commit': '8b5ca00'}

        if executable('fzf')
            Plug 'junegunn/fzf', {'tag': '0.18.0'}
            Plug 'junegunn/fzf.vim', {'commit': 'b31512e'}
        endif
    call plug#end()
endif

filetype plugin indent on
silent! packadd! matchit

silent! syntax enable

set notermguicolors
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

set foldmethod=syntax
setlocal foldlevelstart=99
setlocal foldlevel=99

" Store swapfiles in ~/tmp/vim.
if !isdirectory($HOME . "/tmp/vim")
    call mkdir($HOME . "/tmp/vim", "p")
endif
set directory=$HOME/tmp/vim

" Filetypes for file extensions
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python
autocmd vimrc BufRead,BufNewFile Jenkinsfile set filetype=groovy

map <leader>e :Explore<cr>
map <leader>s :Sexplore<cr>
map <leader>v :Vexplore<cr>
let g:netrw_banner = 0  " Hide banner.

map <leader><leader> :FZF<cr>
map <leader>f :FZF<cr>

let g:ale_set_signs = 0
let g:ale_linters = {'python': ['flake8']}

" Strip trailing whitespace on write, preserving window view.
function! s:StripTrailingWhitespace()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfun
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespace()
command WritePreservingWhitespace noautocmd w

" Commands to switch indentation style in current buffer
command TwoSpaceTabs setlocal expandtab ts=2 sts=2 shiftwidth=2
command FourSpaceTabs setlocal expandtab ts=4 sts=4 shiftwidth=4

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
inoremap <C-F> <Esc>gUiw`]a

if executable("rg")
    set grepprg=rg\ -i\ --vimgrep\ $*
else
    set grepprg=grep\ -riIn\ $*\ /dev/null
endif

" Use colorscheme colors for fzf. From the fzf.vim readme.
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
    \ }
