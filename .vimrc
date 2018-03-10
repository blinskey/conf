" vim: set foldmethod=marker:

" Emulate Vi when invoked as such. This works with Debian's 'vim.basic' binary.
if v:progname == 'vi'
    set compatible
    syntax off
    finish
endif

" Remove all autocommands for the current group. Prevents commands from being
" duplicated when .vimrc is sourced multiple times.
augroup vimrc
    autocmd!
augroup END

" {{{1 vim-plug ===============================================================

" See https://github.com/junegunn/vim-plug
"
" Usage:
" - :PlugInstall to install the plugins listed below
" - :PlugUpdate to update plugins
" - :PlugUpgrade to update vim-plug

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

    Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
    Plug 'ervandew/supertab'               " Autocompletion with tab.
    Plug 'tacahiroy/ctrlp-funky'           " Ctrlp extension for search within buffer.
    Plug 'cocopon/iceberg.vim'

    " ALE linter plugin requires async support.
    let s:use_ale = v:version >= 800
    if s:use_ale
        Plug 'w0rp/ale'
    endif

    call plug#end()
endif

"{{{1 Miscellaneous ===========================================================

set nocompatible

if v:version >= 800
    " Enable Western Armenian keymapping.
    set keymap=armenian-western_utf-8

    " Disable keymap by default. (Use Ctrl-^ to switch in insert mode.)
    set iminsert=0
    set imsearch=0
endif

" Enable plugins
filetype plugin on

" File-extension-specific syntax settings
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf

" Map <leader> to comma.
let mapleader=","

" Enable spellchecking in prose files.
autocmd vimrc BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

" Set path to word list for spellchecking.
set spellfile=~/.vim/spellfile.utf-8.add

" Disable spellchecking in help documentation.
autocmd vimrc FileType help setlocal nospell

" Always show status line on last window.
set laststatus=2

" Always show tab line.
set showtabline=2

" Show mode in last line.
set showmode

" Time out on key codes after 50 ms.
set ttimeout
set ttimeoutlen=50

" Make sure the encoding is set to UTF-8.
set encoding=utf-8
set termencoding=utf-8

" When substituting, substitute for all matches in each line by default.
set gdefault

" Never conceal text.
set conceallevel=0

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
" Taken from ":h uppercase".
map! <C-F> <Esc>gUiw`]a

" Check for modelines in the first and last lines.
set modelines=1

" Set the encryption method to use with :X.
if has("patch-7.4.401")
    set cryptmethod=blowfish2
endif

" ttymouse must be set to xterm2, not xterm, to enable resizing of windows
" using the mouse. Requires a relatively modern terminal emulator.
" Use 'set mouse=n' to enable resizing of windows in normal mode.
set ttymouse=xterm2

" Enable mouse in Normal mode.
set mouse=n

" Strip trailing whitespace on write, preserving window view.
" Note that this is applied to all file types, even though there are a few
" where this may not be desireable.
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

"{{{1 Appearance ==============================================================

" Enable syntax highlighting.
if has("syntax")
    syntax enable
endif

" Use 256-color terminal when not using GUI colors.
set t_Co=256

if has('termguicolors')
    " Use 24-bit color.
    " See :h termguicolors and :h xterm-true-color for details.
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    let s:using_24_bit_color = &termguicolors || has("gui_running")
endif

set colorcolumn=80

set background=dark

colorscheme iceberg

" Show line numbers.
set number

" Highlight current line. Very slow in some environments.
set nocursorline

" Disable cursorline underline set by some colorschemes.
hi Cursorline gui=none cterm=none

" Limit redraws to improve performance.
set lazyredraw

" Don't show whitespace.
set nolist

" Define whitespace characters to print when showlist is enabled.
set listchars=tab:>-,trail:~,extends:>,precedes:<

"{{{1 Statusline ==============================================================

" Returns the name of the currently used keymap. Like %k, but prettier.
function! StatuslineKeymap()
    if &keymap == '' || &iminsert == 0
        return ''
    endif

    if b:keymap_name == 'hy'
        return 'Հայերէն'
    endif
endfunction

set statusline=%y%q\ %f%r%h%w%m\ \%=\ %{StatuslineKeymap()}\ \|\ %l:%c\ \|\ %p%%\ \|

if s:use_ale
    function! LinterStatus() abort
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors
        return printf(' W: %d E: %d ', all_non_errors, all_errors)
    endfunction

    set statusline+=%{LinterStatus()}
endif

set statusline+=%*

"{{{1 Indentation and tabs ====================================================

" Insert spaces rather than tabs.
set expandtab

" Show tabs as four spaces.
set tabstop=4

" Print four spaces when entering a tab.
set softtabstop=4

" Indent by four columns.
set shiftwidth=4

" Use expandtab if detectindent cannot automatically set value.
let g:detectindent_preferred_expandtab = 1

" Use a four-space indent if detectindent cannot automatically set values.
let g:detectindent_preferred_indent = 4

" Use preferred values defined above if file mixes tabs and spaces.
let g:detectindent_preferred_when_mixed = 1

" Limit number of lines analyzed by detectindent.
let g:detectindent_max_lines_to_analyse = 1024

" Load indent file for specific filetypes.
filetype indent on

" Use two-space tabs for certain filetypes.
autocmd vimrc Filetype html,htmldjango,css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

"{{{1 Search ==================================================================

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

"{{{1 Formatting ==============================================================

" Hard-wrap lines after 79 characters.
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

" Don't soft-wrap lines.
set nowrap


"{{{1 netrw ===================================================================

" Open netrw.
map <leader>e :Explore<cr>

" Use tree-style view.
let g:netrw_liststyle = 3

" Hide the banner at the top of the window.
let g:netrw_banner = 0

" Ignore files that we don't want to open.
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc,^tags$,\.git'

"{{{1 Completion ==============================================================

" Populate suggestions from current file, other buffers, and tags file.
set complete=.,b,u,]

"{{{1 ctrlp-funky =============================================================

" Open the CtrlPFunky function search window.
nnoremap <Leader>f :CtrlPFunky<Cr>

"{{{1 SuperTab ================================================================

" Disable autocomplete before and after certain characters.
let g:SuperTabNoCompleteBefore = [' ', '\t']
let g:SuperTabNoCompleteAfter = ['^', ',', ' ', '\t', ')', ']', '}', ':', ';', '#']

"{{{1 ALE =====================================================================

if s:use_ale
    " Set this to 1 to always show errors in a quickfix list.
    let g:ale_open_list = 0

    " Always show the gutter so that the text doesn't jump around as errors are
    " detected and resolved.
    let g:ale_sign_column_always = 1

    "let g:ale_lint_on_text_changed = 'never'
    let g:ale_set_loclist = 1
    let g:ale_set_quickfix = 0

    " The default delay of 10 ms can cause serious lag when editing files
    " with more than a few errors.
    let g:ale_echo_delay = 100
endif

"{{{1 ctrlp ===================================================================

" Open menu by pressing <leader> twice.
let g:ctrlp_map='<leader><leader>'

" Set base directory to cwd or nearest ancestor with version control file.
let g:ctrlp_working_path_mode = 'rw'

" Preserve cache across sessions.
let g:ctrlp_clear_cache_on_exit = 0

" Include dotfiles.
let g:ctrlp_show_hidden = 1

"{{{1 Folding =================================================================

" NOTE: The 'syntax' method causes horrible lag in C files.
set foldmethod=indent
"set foldmethod=syntax
autocmd vimrc FileType python set foldmethod=indent
autocmd vimrc BufRead,BufNewFile .vimrc set foldmethod=marker

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

"{{{1 JSON ====================================================================

" Don't conceal quotes.
let g:vim_json_syntax_conceal = 0

"{{{1 DelimitMate =============================================================

let delimitMate_autoclose = 1
let delimitMate_expand_cr = 2
let delimitMate_insert_eol_marker = 2

"{{{1 Python ==================================================================

" Use Python syntax for type hinting stub files.
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python
