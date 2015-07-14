" Pathogen (https://github.com/tpope/vim-pathogen)
execute pathogen#infect()

" Appearance
syntax enable
colorscheme Tomorrow-Night 

" Show line numbers
" set number

" Indentation and tab settings
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
filetype indent on

" Search case sensitivity settings
set ignorecase
set smartcase

" Disable vi compatibility
set nocompatible

" Enable plugins
filetype plugin on

" Use Markdown syntax highlighting for .md files.
au BufRead,BufNewFile *.md set filetype=markdown

" Line wrapping
set wrap
set textwidth=80

" Git commit settings. (Thanks to
" http://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
autocmd Filetype gitcommit setlocal spell textwidth=72

