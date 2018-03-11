"=== Basic Setup =========================================================={{{1
" Emulate vi when invoked as such.
if v:progname == 'vi'
    set compatible
    syntax off
    finish
endif

" Disable vi emulation.
set nocompatible

" Enable filetype-specific plugin and indentation files.
filetype plugin indent on

" Don't duplicate commands when sourcing this file multiple times.
augroup vimrc
    autocmd!
augroup END

"=== Plugins =============================================================={{{1

" To install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/bundle')

    " Python auto-indent fixes
    Plug 'Vimjas/vim-python-pep8-indent'

    " Colorscheme
    Plug 'cocopon/iceberg.vim'

    " Fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    " Load settings from .editorconfig
    Plug 'editorconfig/editorconfig-vim'

    " Go tools
    Plug 'fatih/vim-go'

    " Linter support -- requires async.
    let s:use_ale = v:version >= 800
    if s:use_ale
        Plug 'w0rp/ale'
    endif

    call plug#end()
endif

if has('packages')
    " Enable the built-in matchit plugin.
    packadd! matchit
endif

"=== General =============================================================={{{1

" Use comma as leader.
let mapleader=","

" Auto-reload files changed outside of Vim if they haven't been changed in Vim.
set autoread

" Set the encryption method to use with :X.
if has("patch-7.4.401")
    set cryptmethod=blowfish2
endif

" Check for modelines in the first and last lines.
set modelines=1

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

" Store all swapfiles in a central directory.
set directory=$HOME/.vim/swap

" Substitute for all matches in each line by default.
set gdefault

" Never conceal text.
set conceallevel=0

" Make sure the encoding is set to UTF-8.
set encoding=utf-8
set termencoding=utf-8

"=== Input ================================================================{{{1

" Հայերէն -- disabled by default. Use Ctrl-^ to switch in Insert mode.
if v:version >= 800
    set keymap=armenian-western_utf-8
    set iminsert=0
    set imsearch=0
endif

" Disable mouse.
set mouse=

" Defines how mouse codes are handled.
set ttymouse=xterm2

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
map! <C-F> <Esc>gUiw`]a

" Don't imitate vi backspace behavior.
set backspace=indent,eol,start

" Don't soft-wrap lines.
set nowrap

" Hard-wrap lines at 79 characters.
set textwidth=79

set formatoptions-=t " Disable text auto-wrapping
set formatoptions+=c " Enable comment auto-wrapping
set formatoptions+=q " Enable formatting of comments with 'gq'
set formatoptions+=n " Recognize and format numbered lists
set formatoptions+=l " Don't auto-wrap if line was already longer than tw
set formatoptions+=1 " Try not to break after a one-letter word
set formatoptions+=j " Remove comment leader when joining lines

" Auto-wrap plain text.
autocmd vimrc FileType text setlocal formatoptions+=t
"
" Enable and configure the command-line completion window.
set wildmenu
set wildmode=longest,list
set wildignore=*.o,*.obj,*.pyc,.git
set wildignorecase

" Time out on key codes after 50 ms.
set ttimeout
set ttimeoutlen=50

"=== Filetype-Specific Settings ==========================================={{{1

" Set filetype based on file extensions.
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf

" Don't conceal quotes.
let g:vim_json_syntax_conceal = 0

" Use Python syntax for type hinting stub files.
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python

"=== Spellchecking ========================================================{{{1

" Enable spellchecking in prose files.
autocmd vimrc BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

" Spellchecking word list
set spellfile=~/.vim/spellfile.utf-8.add

" Don't spellcheck in help docs.
autocmd vimrc FileType help setlocal nospell

"=== Color and Syntax Highlighting ========================================{{{1

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

" Use iceberg colorscheme. Silence error if not installed.
silent! colorscheme iceberg

" This should already be set by iceberg but can't hurt.
set background=dark

"=== Interface ============================================================{{{1

" Don't display intro message on startup.
set shortmess+=I

" Guideline at column 80.
set colorcolumn=80

" Show line numbers.
set number

" Cursorline is useful, but can be very slow.
set nocursorline

" Minimize redraws to improve performance.
set lazyredraw

" Don't show whitespace.
set nolist

" Define whitespace characters to print when list is enabled.
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Always show status line on last window.
set laststatus=2

" Always show tab line.
set showtabline=2

" Show mode in last line.
set showmode

" Set scroll boundaries.
set scrolloff=1
set sidescrolloff=5

" Open new windows to the right and bottom of current window.
set splitbelow
set splitright

"=== Statusline ==========================================================={{{1

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


"=== Indentation =========================================================={{{1

" Use spaces, not tabs, with four spaces for indentation.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use two-space tabs for certain filetypes.
autocmd vimrc Filetype html,htmldjango,css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set autoindent
set smarttab

"=== Search ==============================================================={{{1

" Ignore case when the search pattern contains only lowercase letters.
set smartcase

" Show search matches as the pattern is being typed.
set incsearch

" By default, don't highlight search matches.
set nohlsearch

" Clear search highlighing by hitting Enter.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Toggle search highlighting mode with F4.
nnoremap <F4> :set hlsearch! hlsearch?<CR>

"=== netrw ================================================================{{{1

map <leader>e :Explore<cr>

" Tree-style view
let g:netrw_liststyle = 3

" Hide banner
let g:netrw_banner = 0

" Ignore list
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc,^tags$,\.git'

"=== Folds ================================================================{{{1

" Fold using indents. ('Syntax' can be nice, but is sometimes very slow.)
set foldmethod=indent

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

"=== Completion ==========================================================={{{1

" Insert-mode completion shortcuts recommended in :h ins-completion
:inoremap ^] ^X^]
:inoremap ^F ^X^F
:inoremap ^D ^X^D
:inoremap ^L ^X^L

"=== Ctrlp ================================================================{{{1

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

"=== ALE =================================================================={{{1

if s:use_ale
    " Set this to 1 to always show errors in a quickfix list.
    let g:ale_open_list = 0

    " Always show the gutter so that the text doesn't jump around as errors are
    " detected and resolved.
    let g:ale_sign_column_always = 1

    let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 0

    let g:ale_echo_delay = 100
endif

"}}}
" vi: set foldmethod=marker foldlevel=0:
