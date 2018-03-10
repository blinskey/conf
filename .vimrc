" When invoked as 'vi', try to emulate good, old, unimproved vi.
if v:progname == 'vi'
    set compatible
    syntax off
    finish
endif

" Remove all autocommands in the 'vimrc' group. Prevents commands from being
" duplicated when .vimrc is sourced multiple times.
augroup vimrc
    autocmd!
augroup END

" Try to automatically install plug.vim if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimrc VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/bundle')

    "Plug 'Raimondi/delimitMate'            " Automatic parenthesis completion.
    "Plug 'Vimjas/vim-python-pep8-indent'   " Python formatting improvements.
    "Plug 'jmcantrell/vim-virtualenv'       " Use Python virtualenvs.
    "Plug 'tpope/vim-endwise'               " Automatically add 'fi', &c. at end of blocks.
    "Plug 'editorconfig/editorconfig-vim'
    "Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
    "Plug 'ervandew/supertab'               " Autocompletion with tab.
    "Plug 'tacahiroy/ctrlp-funky'           " Ctrlp extension for search within buffer.

    Plug 'cocopon/iceberg.vim'

    " ALE linter plugin requires async support.
    let s:use_ale = v:version >= 800
    if s:use_ale
        Plug 'w0rp/ale'
    endif

    call plug#end()
endif

set nocompatible

" Հայերէն -- disabled by default. Use Ctrl-^ to switch in Insert mode.
if v:version >= 800
    set keymap=armenian-western_utf-8
    set iminsert=0
    set imsearch=0
endif

filetype plugin on

" File-extension-specific syntax settings
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf

let mapleader=","

" Enable spellchecking in prose files.
autocmd vimrc BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

set spellfile=~/.vim/spellfile.utf-8.add  " Spellchecking word list
autocmd vimrc FileType help setlocal nospell  " Don't spellcheck in help docs.

set laststatus=2 " Always show status line on last window.
set showtabline=2   " Always show tab line.
set showmode  " Show mode in last line.

" Time out on key codes after 50 ms.
set ttimeout
set ttimeoutlen=50

" Make sure the encoding is set to UTF-8.
set encoding=utf-8
set termencoding=utf-8

set gdefault  " Substitute for all matches in each line by default.

set conceallevel=0  " Never conceal text.

" Enable and configure the command-line completion window.
set wildmenu
set wildmode=longest,list:longest
set wildignore=*.o,*.obj,*.pyc

" Set scroll boundaries.
set scrolloff=1
set sidescrolloff=5

" Auto-reload files changed outside of Vim if they haven't been changed
" inside of Vim.
set autoread

if has('packages')
    " Enable the built-in matchit plugin.
    packadd! matchit
endif

" Open new windows to the right and bottom of current window.
set splitbelow
set splitright

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
map! <C-F> <Esc>gUiw`]a

set modelines=1   " Check for modelines in the first and last lines.

" Set the encryption method to use with :X.
if has("patch-7.4.401")
    set cryptmethod=blowfish2
endif

set mouse=n  " Enable mouse in Normal mode.
set ttymouse=xterm2  " Defines how mouse codes are handled.

" Strip trailing whitespace on write, preserving window view.  Note that this
" may not be desirable in some file types.
function! s:StripTrailingWhitespace()
    let l:view = winsaveview()
    %s/\s\+$//e
    call winrestview(l:view)
endfun
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespace()

" Open help in a vertical split if there is enough room.
function! s:position_help()
    if winwidth(0) >= 160
        wincmd L
    endif
endfunction
autocmd vimrc FileType help call s:position_help()

" Enable syntax highlighting.
if has("syntax")
    syntax enable
endif

" Use 24-bit color if available, or 256 colors otherwise.
" See :h termguicolors, :h xterm-true-color.
if has('termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
    set t_Co=256
endif

colorscheme iceberg
set background=dark

set colorcolumn=80  " Guideline at column 80.

set number  " Show line numbers.

set nocursorline  " This is very slow in some environments.
"hi Cursorline gui=none cterm=none  " Disable cursorline underline.

set lazyredraw  " Limit redraws to improve performance.

set nolist  " Don't show whitespace.
" Define whitespace characters to print when list is enabled.
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Statusline
set statusline=%y%q\ %f%r%h%w%m\ \%=\ %k\ \|\ %l:%c\ \|\ %p%%\ \|
if s:use_ale
    function! LinterStatus() abort
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors
        return printf(' W: %d E: %d ', all_non_errors, all_errors)
    endfunction
    set statusline+=%{LinterStatus()}
endif

set expandtab  " Use spaces, not tabs.
set tabstop=4  " A tab counts as four spaces.
set softtabstop=4  " A tab counts as four spaces when editing.
set shiftwidth=4  " Indent by four spaces.

filetype indent on

" Use two-space tabs for certain filetypes.
autocmd vimrc Filetype html,htmldjango,css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set autoindent
set backspace=indent,eol,start
set smarttab

" Ignore case when the search pattern contains only lowercase letters.
set ignorecase
set smartcase

" Show search matches as the pattern is being typed.
set incsearch

" By default, don't highlight search matches.
set nohlsearch

" Clear search highlighing by hitting Enter.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Toggle search highlighting mode with F4.
nnoremap <F4> :set hlsearch! hlsearch?<CR>

set nowrap  " Don't soft-wrap lines.
set textwidth=79  " Hard-wrap lines at 79 characters.

set formatoptions-=t " Disable text auto-wrapping
set formatoptions+=c " Enable comment auto-wrapping
set formatoptions+=q " Enable formatting of comments with 'gq'
set formatoptions+=n " Recognize and format numbered lists
set formatoptions+=l " Don't auto-wrap if line was already longer than tw
set formatoptions+=1 " Try not to break after a one-letter word
set formatoptions+=j " Remove comment leader when joining lines

" Auto-wrap plain text.
autocmd vimrc FileType text setlocal formatoptions+=t

" netrw
map <leader>e :Explore<cr>
let g:netrw_liststyle = 3  " Tree-style view
let g:netrw_banner = 0  " Hide banner
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc,^tags$,\.git'  " Ignore list

if s:use_ale
    let g:ale_open_list = 0  " Don't show errors in quickfix list.
    let g:ale_sign_column_always = 1  " Always show gutter.
    let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 0
    let g:ale_echo_delay = 100
endif

set foldmethod=indent  " Note: 'syntax' method can be very slow.
autocmd vimrc FileType python set foldmethod=indent
autocmd vimrc BufRead,BufNewFile .vimrc set foldmethod=marker

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

" Don't conceal quotes.
let g:vim_json_syntax_conceal = 0

" Use Python syntax for type hinting stub files.
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python
