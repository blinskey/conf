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
    autocmd vimrc VimEnter * PlugInstall
endif

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/bundle')

    "Plug 'AndrewRadev/undoquit.vim'        " Reopen closed windows.
    "Plug 'godlygeek/tabular'               " Text alignment.
    "Plug 'jeetsukumaran/vim-buffergator'   " List all buffers.
    Plug 'jmcantrell/vim-virtualenv'       " Use Python virtualenvs.
    "Plug 'justinmk/vim-sneak'              " Quickly jump to a location.
    "Plug 'majutsushi/tagbar'               " Open a window displaying tags in buffer.
    "Plug 'tpope/vim-characterize'          " Adds additional data to 'ga' output.
    "Plug 'tpope/vim-obsession'             " Automated session management.
    "Plug 'tpope/vim-repeat'                " Allows plugins to use the '.' command.
    "Plug 'tpope/vim-surround'              " Manipulate characters enclosing a selection.
    "Plug 'vim-scripts/BufOnly.vim'         " Close everything but a single buffer.
    "Plug 'vim-scripts/a.vim'               " Switch between header and source file.
    "Plug 'wesQ3/vim-windowswap'            " Swap position of arbitrary windows.
    Plug 'Raimondi/delimitMate'            " Automatic parenthesis completion.

    Plug 'ervandew/supertab'               " Autocompletion with tab.
    Plug 'Vimjas/vim-python-pep8-indent'  " Python formatting improvements.

    " Conflicts with DelimitMate.
    "Plug 'tpope/vim-endwise'               " Automatically add 'fi', &c. at end of blocks.

    Plug 'cocopon/iceberg.vim'             " Color scheme.
    Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
    Plug 'tacahiroy/ctrlp-funky'           " Ctrlp extension for search within buffer.
    Plug 'fatih/vim-go'                    " Golang tools.

    " ALE linter plugin requires async support.
    let s:use_ale = v:version >= 800
    if s:use_ale
        Plug 'w0rp/ale'
    endif

    call plug#end()
endif

"{{{1 Miscellaneous ===========================================================

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
set cryptmethod=blowfish2

" ttymouse must be set to xterm2, not xterm, to enable resizing of windows
" using the mouse. Requires a relatively modern terminal emulator.
" Use 'set mouse=n' to enable resizing of windows in normal mode.
set ttymouse=xterm2

" Strip trailing whitespace on save.
autocmd vimrc BufWritePre * %s/\s\+$//e

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
hi comment guifg=#888888

" Show line numbers.
set number

" Highlight current line.
set cursorline

" Disable cursorline underline set by some colorschemes.
hi Cursorline gui=none cterm=none

" Limit redraws to offset slowdown from cursorline.
set lazyredraw

" Don't show whitespace.
set nolist

" Define whitespace characters to print when showlist is enabled.
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Enable all Python syntax highlighting options.
let python_highlight_all = 1

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

function! StatuslineVenv()
    let l:txt = virtualenv#statusline()
    if l:txt == ''
        return ''
    else
        return '[venv: ' . l:txt . ']'
    endif
endfunction

set statusline=%y%q\ %f%r%h%w%m\ \%=\ %{StatuslineKeymap()}\ %{StatuslineVenv()}\ \|\ %l:%c\ \|\ %p%%\ \|

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
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc,tags,\.git'

"{{{1 Completion ==============================================================

" Populate suggestions from current file, other buffers, and tags file.
set complete=.,b,u,]

" Add 'k' to ':set complete' list to enable dictionary completion.
set dictionary+=/usr/share/dict/words

" Mappings suggested in :h ins-completion:

" Tags
inoremap <C-]> <C-X><C-]>

" Filenames
"inoremap <C-F> <C-X><C-F>

" Definitions or macros
inoremap <C-D> <C-X><C-D>

" Whole lines
inoremap <C-L> <C-X><C-L>

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
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 0

    " The default delay of 10 ms can cause serious lag when editing files
    " with more than a few errors.
    let g:ale_echo_delay = 500
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

"{{{1 tagbar ==================================================================

" List tags in the order in which they appear in the source file.
let g:tagbar_sort = 0

" Toggle tagbar with F8.
nnoremap <silent> <F8> :TagbarToggle<CR>

" Toggle the tagbar with <leader>+t.
nmap <silent> <leader>t :TagbarToggle<CR>

" On a 190-column screen, this leaves room for two 80-column windows, plus some
" padding.
let g:tagbar_width = 30

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

"{{{1 PHP =====================================================================

" Improve doc comment syntax. From the php.vim readme.

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

"{{{1 JSON ====================================================================

" Don't conceal quotes.
let g:vim_json_syntax_conceal = 0

"{{{1 python.vim ==============================================================

" Enable all syntax-highlighting features.
let python_highlight_all = 1

"{{{1 Jedi ====================================================================

" Don't automatically pop up completion box when a period is entered.
" Use the completion key to open the completion box.
let g:jedi#popup_on_dot = 0

" Wait 1 second before showing call signature.
let g:jedi#show_call_signatures_delay = 1000

" Rename with <leader>r
nnoremap <silent> <buffer> <localleader>r :call jedi#rename()<cr>

" Don't auto-complete 'import' after 'from ...'.
let g:jedi#smart_auto_mappings = 0

"{{{1 Auto-Pairs ==============================================================

" Disable problematic behavior when inserting closing delimiter within existing
" delimiter pair.
let g:AutoPairsMultilineClose = 0

"{{{1 DelimitMate =============================================================

let delimitMate_autoclose = 1
let delimitMate_expand_cr = 2
let delimitMate_insert_eol_marker = 2

"{{{1 A.vim ===================================================================

" Toggle between header and source files with <leader>+a.
nnoremap <silent> <leader>a :A<CR>

"{{{1 Python ==================================================================

" Use Python syntax for type hinting stub files.
autocmd vimrc BufRead,BufNewFile *.pyi set filetype=python

"{{{1 GitGutter ===============================================================

" Workaround for conflict between GitGutter and ctrlp-funky.
" See https://github.com/tacahiroy/ctrlp-funky/issues/85
let g:gitgutter_async = 0

"{{{1 vim-go ==================================================================

" Don't auto-populate new files from template.
let g:go_template_autocreate = 0
