" Remove all autocommands for the current group. Prevents commands from being
" duplicated when .vimrc is sourced multiple times.
:autocmd!

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

    Plug 'Shougo/unite.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'airblade/vim-gitgutter'
    Plug 'bling/vim-airline'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'ervandew/supertab'
    Plug 'flazz/vim-colorschemes'
    Plug 'jeetsukumaran/vim-buffergator'
    Plug 'jiangmiao/auto-pairs'
    Plug 'majutsushi/tagbar'
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
    Plug 'wesQ3/vim-windowswap'

    "Plug 'Raimondi/delimitMate'
    "Plug 'bling/vim-bufferline'
    "Plug 'edkolev/promptline.vim'
    "Plug 'edkolev/tmuxline.vim'
    "Plug 'gcmt/taboo.vim'
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
au BufRead,BufNewFile *.md,TODO set filetype=markdown

" Write with root privileges.
cmap sudow w !sudo tee > /dev/null %

" Map <leader> to comma.
let mapleader=","

" Spellcheck
autocmd BufRead,BufNewFile *.{md,txt} setlocal spell spelllang=en_us

" Always show status line on last window.
set laststatus=2

" Always show tab line.
set showtabline=2

" Don't show mode in last line. Mode is displayed by Airline.
set noshowmode

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

" Show line numbers
set number

" Highlight current line
set cursorline

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
      au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
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

" Don't highlight search matches.
" TODO: Toggle this with a key?
set nohlsearch

" Clear search highlighing by hitting Enter.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

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

" Using Supertab plugin instead.
"imap <Tab> <C-P>

" Populate suggestions from current file, other buffers, and tags file.
set complete=.,b,u,]

" Replacement settings, similar to zsh defaults.
set wildmode=longest,list:longest

" Add 'k' to :set complete list to enable dictionary completion.
set dictionary+=/usr/share/dict/words

"=== SuperTab =================================================================

" Disable autocomplete before and after certain characters.
let g:SuperTabNoCompleteBefore = ['\s', '\t']
let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '\t']

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

let g:syntastic_javascript_checkers = ["eslint"]

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
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"=== tagbar ===================================================================

" Enable Airline tagbar plugin integration.
let g:airline#extensions#tagbar#enabled = 1

" Jump to tagbar with Ctrl+t, opening it if it is currently closed and keeping
" it open after selecting a function.
nmap <C-t> :TagbarOpen fj<CR>

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

" Start with all folds open.
set foldlevelstart=99
