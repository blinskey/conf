" Emulate vi when invoked as such.
if v:progname == 'vi'
    set compatible
    set noloadplugins
    set t_Co=0
    set shortmess+=I
    finish
endif

" Disable vi emulation.
set nocompatible

" Don't duplicate commands when sourcing this file multiple times.
augroup vimrc
    autocmd!
augroup END

" Enable filetype-specific plugin and indentation files.
filetype plugin indent on

if has('packages')
    " Enable the built-in matchit plugin.
    packadd! matchit
endif

" Strip trailing whitespace on write, preserving window view.  Note that this
" may not be desirable in some file types.
function! s:StripTrailingWhitespace()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfun
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespace()

" Make sure the encoding is set to UTF-8.
set encoding=utf-8

" Make ~ behave as an operator.
set tildeop

" Հայերէն
if v:version >= 800
    silent! set keymap=armenian-western_utf-8
    set iminsert=0
    set imsearch=0
endif

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
map! <C-F> <Esc>gUiw`]a

" Don't soft-wrap lines.
set nowrap

" Hard-wrap lines at 79 characters.
set textwidth=79

set formatoptions-=t " Disable text auto-wrapping.
set formatoptions+=c " Enable comment auto-wrapping.
set formatoptions+=q " Enable formatting of comments with 'gq'.
set formatoptions+=n " Recognize and format numbered lists.
set formatoptions+=l " Don't auto-wrap if line was already longer than tw.
set formatoptions+=1 " Try not to break after a one-letter word.
set formatoptions+=j " Remove comment leader when joining lines.

" Auto-wrap plain text.
autocmd vimrc FileType text setlocal formatoptions+=t

" Enable and configure the command-line completion window.
set wildmode=longest,list
set wildignore=*.o,*.obj,*.pyc,.git

" Use Vi-style backspacing.
set backspace=

" Set filetype based on file extensions.
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf

" Set filetype for Python type hinting stub files.
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python

" Enable syntax highlighting.
if has("syntax")
    syntax enable
endif

silent! colorscheme iceberg

" Don't display intro message on startup.
set shortmess+=I

" Guideline at column 80.
set colorcolumn=80

set ruler

" Use spaces, not tabs, with four spaces for indentation.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use two-space tabs for certain filetypes.
autocmd vimrc Filetype html,htmldjango,css,javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set autoindent
set smarttab

" Ignore case when the search pattern contains only lowercase letters.
set ignorecase
set smartcase

" Fold using indents. ('Syntax' can be nice, but is sometimes very slow.)
set foldmethod=indent

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

" Mappings to open netrw
map <leader>e :Explore<cr>
map <leader>s :Sexplore<cr>
map <leader>v :Vexplore<cr>

" Hide netrw banner.
let g:netrw_banner = 0

" Open menu by pressing <leader> twice.
let g:ctrlp_map='<leader><leader>'

" Search all tags with <leader>t.
nnoremap <leader>t :CtrlPTag<CR>

" Search tags in current buffer with <leader>b.
nnoremap <leader>b :CtrlPBufTag<CR>

" Search tags in all buffers with <leader>b.
nnoremap <leader>a :CtrlPBufTagAll<CR>

" Set base directory to cwd or nearest ancestor with version control file.
let g:ctrlp_working_path_mode = 'rw'

" Preserve cache across sessions.
let g:ctrlp_clear_cache_on_exit = 0

" Include dotfiles.
let g:ctrlp_show_hidden = 1

" Don't print signs on lines with warnings or errors.
let g:ale_set_signs = 0

" Specify custom sets of linters for filetypes.
let g:ale_linters = {'python': ['flake8']}
