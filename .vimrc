" Remove all autocommands for the current group. Prevents commands from being
" duplicated when .vimrc is sourced multiple times.
autocmd!

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

    Plug 'AndrewRadev/undoquit.vim'
    Plug 'Shougo/unite.vim'
    Plug 'StanAngeloff/php.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'airblade/vim-gitgutter'
    Plug 'benmills/vimux'
    Plug 'bling/vim-airline'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'digitaltoad/vim-jade'
    Plug 'ervandew/supertab'
    Plug 'flazz/vim-colorschemes'
    Plug 'groenewege/vim-less'
    Plug 'jiangmiao/auto-pairs'
    Plug 'majutsushi/tagbar'
    Plug 'othree/html5-syntax.vim'
    Plug 'othree/html5.vim'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'pangloss/vim-javascript'
    Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/syntastic'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'tpope/vim-afterimage'
    Plug 'tpope/vim-capslock'
    Plug 'tpope/vim-characterize'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-jdaddy'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-scripts/BufOnly.vim'
    Plug 'vim-utils/vim-man'
    Plug 'wesQ3/vim-windowswap'

    "Plug 'Raimondi/delimitMate'
    "Plug 'bling/vim-bufferline'
    "Plug 'edkolev/promptline.vim'
    "Plug 'edkolev/tmuxline.vim'
    "Plug 'gcmt/taboo.vim'
    "Plug 'jeetsukumaran/vim-buffergator'
    "Plug 'mhinz/vim-signifyg'
    "Plug 'tpope/vim-sleuth'
    "Plug 'tpope/vim-vinegar'
    "Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'

    call plug#end()
endif

"=== Miscellaneous ============================================================

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" Use Markdown syntax for .md and to-do list files.
autocmd BufRead,BufNewFile *.md,TODO set filetype=markdown

" Map <leader> to comma.
let mapleader=","

" Enable spellchecking in prose files.
autocmd BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

" Disable spellchecking in help documentation.
autocmd FileType help setlocal nospell

" Always show status line on last window.
set laststatus=2

" Always show tab line.
set showtabline=2

" Don't show mode in last line. Mode is displayed by Airline.
set noshowmode

" Time out on key codes after 50 ms.
set ttimeoutlen=50

" Since we remap <C-L> for window navigation below, set a new mapping
" to redraw the screen.
nnoremap <silent> <leader>l :redraw!<CR>

" Crude macro to surround unquoted word with quotes.
let @q = 'viwoi"xea"'

"=== Mouse ====================================================================

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

"=== Appearance ===============================================================

" Enable syntax highlighting.
syntax enable

" Use 256-color terminal.
set t_Co=256

" Set and configure Molokai color scheme.
" NOTE: Order matters here!
silent! colorscheme molokai
let g:rehash256 = 1
set background=dark

" Modify brace-match highlighting to make it easier to keep track of the
" cursor.
highlight MatchParen cterm=bold ctermbg=none ctermfg=208

" Show line numbers
set number

" Highlight current line
set cursorline

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
    "highlight ColorColumn ctermbg=240
else
      autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"=== Indentation and tabs =====================================================

" Autoindent when starting a new line.
set smartindent

" Insert spaces rather than tabs.
set expandtab

" Show tabs as four spaces.
set tabstop=4

" Print four spaces when entering a tab.
set softtabstop=4

" Indent by four columns.
set shiftwidth=4

" Load indent file for specific filetypes.
filetype indent on

" Use two-space tabs in Markdown files.
autocmd Filetype markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

"=== Search ===================================================================

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

"=== Line wrapping ============================================================

" Don't soft-wrap lines.
set nowrap

" Hard-wrap lines after 79 characters.
set textwidth=79

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

"=== netrw ====================================================================

" Open netrw.
"map <leader>e :Explore<cr>

" Use tree-style view.
"let g:netrw_liststyle=3

"=== NERDTree =================================================================

nmap <leader>e :NERDTreeToggle<Cr>

"=== ctrlp-funky ==============================================================

" Open the CtrlPFunky function search window.
nnoremap <Leader>fu :CtrlPFunky<Cr>

" Open CtrlPFunky with search field prepopulated with word under cursor.
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"=== Autocomplete =============================================================

" Based on https://robots.thoughtbot.com/vim-macros-and-you
" See :h ins-completion

" Populate suggestions from current file, other buffers, and tags file.
set complete=.,b,u,]

" Replacement settings, similar to zsh defaults.
set wildmode=longest,list:longest

" Add 'k' to :set complete list to enable dictionary completion.
set dictionary+=/usr/share/dict/words

"=== SuperTab =================================================================

" Disable autocomplete before and after certain characters.
let g:SuperTabNoCompleteBefore = [' ', '\t']
let g:SuperTabNoCompleteAfter = ['^', ',', ' ', '\t', ')', ']', '}', ':', ';']

"=== Splits ===================================================================

" Based on https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
" See :h splits

" Simple window movement. Note that <C-K> conflicts with current tmux prefix
" binding, so it must be pressed twice.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new windows to the right and bottom of current window.
set splitbelow
set splitright

"=== Syntastic ================================================================

" Recommended newbie settings from Syntastic readme

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" End recommended settings

" Define custom linters for various filetypes.
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_java_checkers = []

" Toggle mode with F9.
nnoremap <F9> :SyntasticToggleMode<CR>

"=== ctrlp ====================================================================

" Set base directory to cwd or nearest ancestor with version control file.
let g:ctrlp_working_path_mode = 'rw'

"=== IndentLine================================================================

" Line color
let g:indentLine_color_term = 239

" List of file types for which indentation line should not be shown
let g:indentLine_fileTypeExclude = ['text']

"=== airline ==================================================================

" Use the Powerline-clone Airline theme.
let g:airline_theme = 'powerlineish'

" Use Powerline fonts. These must be installed and enabled in the terminal.
" See https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

"=== tabline ==================================================================

" Use Airline's tabline integration.
let g:airline#extensions#tabline#enabled = 1

" Show number in tabline.
let g:airline#extensions#tabline#show_tab_nr = 1

" Set tabline number to tab number.
let g:airline#extensions#tabline#tab_nr_type = 1

" Hide close button.
let g:airline#extensions#tabline#show_close_button = 0

" Set the tab name format algorithm.
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'default'

" For unique filenames, print only the filename, not the full path.
let g:airline#extensions#tabline#fnamemod = ':t'
"=== tagbar ===================================================================

" Enable Airline tagbar plugin integration.
let g:airline#extensions#tagbar#enabled = 1

" Toggle tagbar with F8.
nnoremap <silent> <F8> :TagbarToggle<CR>

" Jump to tagbar with <leader>+t, opening it if it is currently closed and
" keeping it open after selecting a function.
nmap <leader>t :TagbarOpen fj<CR>

"=== promptline ===============================================================
"
"let airline#extensions#promptline#snapshot_file = '~/.zsh_prompt.sh'
"let g:promptline_preset = 'clear'

"=== tmuxline =================================================================
"
"let g:airline#extensions#tmuxline#enabled = 1
"let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline"
"let g:tmuxline_preset = 'powerline'

"=== ctags ====================================================================

" Generate tags on write.
"
" For a Git hook-based alternative, see
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
":autocmd BufWritePost * call system("ctags -R")

"=== Folding ==================================================================

" Fold based on indentation.
set foldmethod=indent

" Don't make an exception for any character when folding.
set foldignore=

" Start with all folds open.
set foldlevelstart=99

"=== Unite ====================================================================

call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Recursive search through pwd.
"
" Note: This may be slow for large projects. We could speed things up with
" the unite-source-file_rec/async source, but that requires vim-proc, which
" requires a native extension, which is a bit too heavy.
nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>

" Search buffers.
nnoremap <leader>b :<C-u>Unite buffer<CR>

"=== PHP ======================================================================

" Improve doc comment syntax. From the php.vim readme.

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

"=== vim-man ==================================================================

" Open man page for word under cursor in horizontal or vertical split.
map <leader>k <Plug>(Man)
map <leader>v <Plug>(Vman)
