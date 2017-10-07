" vim: set foldmethod=marker:

" Emulate Vi when invoked as such. This works with Debian's 'vim.basic' binary.
if v:progname == 'vi'
    set compatible
    syntax off
    finish
endif

" Remove all autocommands for the current group. Prevents commands from being
" duplicated when .vimrc is sourced multiple times.
autocmd!

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
    autocmd VimEnter * PlugInstall
endif

if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/bundle')

    Plug 'AndrewRadev/undoquit.vim' " Reopen closed windows.
    Plug 'StanAngeloff/php.vim'
    Plug 'ctrlpvim/ctrlp.vim' " Fuzzy finder
    Plug 'flazz/vim-colorschemes' " Colorscheme collection.
    Plug 'godlygeek/tabular' " Text alignment.
    Plug 'jeetsukumaran/vim-buffergator' " List all buffers.
    Plug 'jmcantrell/vim-virtualenv' " Use Python virtualenvs.
    Plug 'justinmk/vim-sneak' " Quickly jump to a location.
    Plug 'kh3phr3n/python-syntax'
    Plug 'majutsushi/tagbar' " Open a window displaying tags in buffer.
    Plug 'othree/html5-syntax.vim'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'tacahiroy/ctrlp-funky' " Ctrlp extension for search within buffer.
    Plug 'tpope/vim-characterize' " Adds additional data to 'ga' output.
    Plug 'tpope/vim-endwise' " Automatically add 'fi', &c. at end of blocks.
    Plug 'tpope/vim-obsession' " Automated session management.
    Plug 'tpope/vim-repeat' " Allows plugins to use the '.' command.
    Plug 'tpope/vim-speeddating' " <C-A> and <C-X> handle dates intelligently.
    Plug 'tpope/vim-surround' " Manipulate characters enclosing a selection.
    Plug 'vim-scripts/BufOnly.vim' " Close everything but a single buffer.
    Plug 'wesQ3/vim-windowswap' " Swap position of arbitrary windows.

    " Linter: Use asynchronous plugin if Vim support is available.
    let s:use_ale = v:version >= 800
    if s:use_ale
        Plug 'w0rp/ale'
    else
        Plug 'scrooloose/syntastic'
    endif

    "Plug 'airblade/vim-gitgutter' " Git diff markers, &c.
    "Plug 'ciaranm/detectindent' " Automatic indentation settings.
    "Plug 'tmhedberg/SimpylFold' " Python folding.
    "Plug 'vim-scripts/a.vim' " Switch between header and source file.
    "Plug 'Raimondi/delimitMate' " Automatically add closing parentheses, &c.
    "Plug 'Valloric/MatchTagAlways' " Highlight enclosing HTML and XML tags.
    "Plug 'davidhalter/jedi-vim' " Python autocompletion using Jedi library.
    "Plug 'ervandew/supertab' " Built-in completion using Tab.
    "Plug 'rust-lang/rust.vim'

    call plug#end()
endif

"{{{1 Keymap ==================================================================

if v:version >= 800 || !empty(glob('/usr/share/vim/vim74/keymap/armenian-western_utf-8.vim'))
    " Enable Western Armenian keymapping.
    set keymap=armenian-western_utf-8

    " Disable keymap by default. (Use Ctrl-^ to switch in insert mode.)
    set iminsert=0
    set imsearch=0
endif

"{{{1 Miscellaneous ===========================================================

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" File-extension-specific syntax settings
autocmd BufRead,BufNewFile *.md,TODO set filetype=markdown
autocmd BufRead,BufNewFile .gitignore set filetype=conf
autocmd BufRead,BufNewFile .rs set filetype=rust
autocmd BufRead,BufNewFile .di set filetype=d

" Map <leader> to comma.
let mapleader=","

" Enable spellchecking in prose files.
autocmd BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

" Set path to word list for spellchecking.
let s:spellfile_path = '/home/blinskey/code/config-files/vim-spellfile.utf-8.add'
if !empty(glob(s:spellfile_path))
    let &spellfile=s:spellfile_path
endif

" Disable spellchecking in help documentation.
autocmd FileType help setlocal nospell

" Always show status line on last window.
set laststatus=2

" Always show tab line.
set showtabline=2

" Show mode in last line.
set showmode

" Time out on key codes after 50 ms.
set ttimeout
set ttimeoutlen=50

" Since we remap <C-L> for window navigation below, set a new mapping
" to redraw the screen.
nnoremap <silent> <leader>l :redraw!<CR>

" Crude macro to surround unquoted word with quotes.
let @q='viwoi"xea"'

" Make sure the encoding is set to UTF-8.
set encoding=utf-8
set termencoding=utf-8

" When substituting, substitute for all matches in each line by default.
set gdefault

" Never conceal text.
set conceallevel=0

" Ignore various types of files.
set wildignore=*.o,*.obj,*.pyc

" Enable the command-line completion window.
set wildmenu

" Set scroll boundaries.
set scrolloff=1
set sidescrolloff=5

" Auto-reload files changed outside of Vim if they haven't been changed
" inside of Vim.
set autoread

" Enable the built-in matchit plugin.
" FIXME: This fails in Vim 7.
"packadd! matchit

" Open new windows to the right and bottom of current window.
set splitbelow
set splitright

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
" Taken from ":h uppercase".
map! <C-F> <Esc>gUiw`]a

" Check for modelines in the first and last lines.
set modelines=1

" Set the encryption method to use with :X.
set cm=blowfish2

"{{{1 Mouse ===================================================================

" ttymouse must be set to xterm2, not xterm, to enable resizing of windows
" using the mouse. This assumes that we're using a relatively recent terminal
" emulator.
set ttymouse=xterm2

" By default, disable the mouse. Define a command and keymapping to toggle
" the mouse in normal mode.

let s:mouse_mode = 0

function! ToggleMouseMode()
    if s:mouse_mode
        set mouse=
        let s:mouse_mode = 0
        redraw | echom "Mouse disabled"
    else
        set mouse=n
        let s:mouse_mode = 1
        redraw | echom "Mouse enabled"
    endif
endfunction

command! MouseToggle :call ToggleMouseMode()
nnoremap <leader>m :MouseToggle<CR>

"{{{1 Appearance ==============================================================

" Enable syntax highlighting.
syntax enable

" Use 256-color terminal when not using GUI colors.
set t_Co=256

if v:version >= 800
    " Toggle GUI colors on and off. Some colorschemes only properly support
    " either GUI or terminal mode; others support both but look better in one
    " of the two.
    let s:use_gui_colors = 1

    let default_t_8f = &t_8f
    let default_t_8b = &t_8b

    if s:use_gui_colors
        " Use 24-bit color.
        " See :h termguicolors and :h xterm-true-color for details.
        set termguicolors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    else
        set notermguicolors
        let &t_8f = default_t_8f
        let &t_8b = default_t_8b
    endif

    let s:using_24_bit_color = &termguicolors || has("gui_running")

    " If we're in 256-color mode, modify brace-match highlighting to make it
    " easier to keep track of the cursor. If we're in 24-bit-color mode, the
    " built-in highlighting is sufficient.
    if s:using_24_bit_color
        highlight MatchParen cterm=bold ctermbg=none ctermfg=208
    endif
endif

" Some nice colorschemes: jellybeans, Tomorrow-Night, iceberg, ir_black
silent! colorscheme jellybeans

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

" Draw ruler at column 80.
" From http://stackoverflow.com/a/3765575/2530735
if exists('+colorcolumn')
    set colorcolumn=80

    if v:version >= 800 && s:using_24_bit_color
        highlight ColorColumn guibg=Gray
    else
        highlight ColorColumn ctermbg=240
    endif
else
      autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Enable syntax highlighting in Markdown fenced code blocks.
" (For default Markdown plugin.)
let g:markdown_fenced_languages = [
    \'c',
    \'css',
    \'haskell',
    \'html',
    \'java',
    \'javascript',
    \'json',
    \'mysql',
    \'python',
    \'sh',
    \'sql',
    \'xml',
    \'zsh'
\]

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
else
    set statusline+=%{SyntasticStatuslineFlag()}
endif

set statusline+=%*

hi warningmsg guibg=DarkRed guifg=White

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

" Use two-space tabs in Markdown and HTML files.
autocmd Filetype markdown,html,htmldjango,css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

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
autocmd FileType text setlocal formatoptions+=t

" Don't soft-wrap lines.
set nowrap

"{{{1 Whitespace ==============================================================

" Strip trailing whitespace on save.
" From http://stackoverflow.com/a/1618401/2530735
" TODO: Don't strip whitespace after \ at end of line.
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"{{{1 netrw ===================================================================

" Open netrw.
map <leader>e :Explore<cr>

" Use tree-style view.
let g:netrw_liststyle = 3

" Hide the banner at the top of the window.
let g:netrw_banner = 0

" Ignore files that we don't want to open.
let g:netrw_list_hide='.*\.swp$,.*\.swo$,.*\.pyc,tags,\.git'

"{{{1 ctrlp-funky =============================================================

" Open the CtrlPFunky function search window.
nnoremap <Leader>f :CtrlPFunky<Cr>

" Open CtrlPFunky with search field prepopulated with word under cursor.
nnoremap <Leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"{{{1 SuperTab ================================================================

" Disable autocomplete before and after certain characters.
let g:SuperTabNoCompleteBefore = [' ', '\t']
let g:SuperTabNoCompleteAfter = ['^', ',', ' ', '\t', ')', ']', '}', ':', ';', '#']

"{{{1 Completion ==============================================================

" Populate suggestions from current file, other buffers, and tags file.
set complete=.,b,u,]

" Replacement settings
set wildmode=longest,list:longest

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

"{{{1 Syntastic ===============================================================

if !s:use_ale
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " Define custom linters for various filetypes.
    let g:syntastic_javascript_checkers = ["eslint"]
    let g:syntastic_java_checkers = []
    let g:syntastic_json_checkers = ["jsonlint"]
    let g:syntastic_python_checkers = ["flake8", "pylint"]

    let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'

    " Toggle mode with F9.
    nnoremap <F9> :SyntasticToggleMode<CR>
endif

"{{{1 ALE =====================================================================

if s:use_ale
    " Set this to 1 to always show errors in a quickfix list.
    let g:ale_open_list = 0

    " Always show the gutter so that the text doesn't jump around as errors are
    " detected and resolved.
    let g:ale_sign_column_always = 1
endif

"{{{1 ctrlp ===================================================================

" Set base directory to cwd or nearest ancestor with version control file.
let g:ctrlp_working_path_mode = 'rw'

" Preserve cache across sessions.
let g:ctrlp_clear_cache_on_exit = 0

" Include dotfiles.
let g:ctrlp_show_hidden = 1

"{{{1 IndentLine ==============================================================

" Line color
let g:indentLine_color_term = 239

" List of file types for which indentation line should not be shown
let g:indentLine_fileTypeExclude = ['text']

"{{{1 tagbar ==================================================================

" Enable Airline tagbar plugin integration.
let g:airline#extensions#tagbar#enabled = 1

" List tags in the order in which they appear in the source file.
let g:tagbar_sort = 0

" Toggle tagbar with F8.
nnoremap <silent> <F8> :TagbarToggle<CR>

" Jump to tagbar with <leader>+t, opening it if it is currently closed and
" keeping it open after selecting a function.
"nmap <silent> <leader>t :TagbarOpen fj<CR>

" Toggle the tagbar with <leader>+t.
nmap <silent> <leader>t :TagbarToggle<CR>

" On a 190-column screen, this leaves room for two 80-column windows, plus some
" padding.
let g:tagbar_width = 30

"{{{1 ctags ===================================================================

" Generate tags on write.
"
" For a Git hook-based alternative, see
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
":autocmd BufWritePost * call system("ctags -R")

"{{{1 Folding =================================================================

set foldmethod=syntax
autocmd FileType python set foldmethod=indent
autocmd BufRead,BufNewFile .vimrc set foldmethod=marker

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

"{{{1 SimpylFold ==============================================================

" Show docstring preview in fold text.
let g:SimpylFold_docstring_preview = 1

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

"{{{1 Help ====================================================================

" Open help in a vertical split if there is enough room.
function! s:position_help()
    if winwidth(0) >= 160
        wincmd L
    endif
endfunction
autocmd FileType help call s:position_help()

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
autocmd BufRead,BufNewFile *.pyi set filetype=python

"{{{1 GitGutter ===============================================================

" Workaround for conflict between GitGutter and ctrlp-funky.
" See https://github.com/tacahiroy/ctrlp-funky/issues/85
let g:gitgutter_async = 0
