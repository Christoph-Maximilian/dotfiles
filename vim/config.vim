call plug#begin()

if has('nvim')                              " deoplete
    Plug 'Shougo/deoplete.nvim', {
        \ 'commit': '02e48af3b995579a56ecafcda80fc6993ec4b3cf',
        \ 'do': ':UpdateRemotePlugins',
        \ }
else
    Plug 'Shougo/deoplete.nvim', {
        \ 'commit': '02e48af3b995579a56ecafcda80fc6993ec4b3cf',
        \ 'do': ':UpdateRemotePlugins',
        \ }
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'autozimu/LanguageClient-neovim', {
    \ 'commit': 'ec4af74',
    \ 'do': 'bash install.sh',
    \ }                                     " languageserver
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	    " NERDTree git plugin
Plug 'justmao945/vim-clang'	   	    " nvim clang automation

" Language server config
let g:LanguageClient_serverCommands = {
  \ 'python': ['~/.local/bin/pyls', 'v'],
  \ 'cpp': ['~/.local/bin/ccls'],
  \ }

let g:deoplete#enable_at_startup = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Clang-Format
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1

call plug#end()

" NERDTree nmap
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nmap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Vim settings
set ignorecase             " case insensitive searching
set smartcase              " case-sensitive if expresson contains a capital letter
set title                  " set terminal title
set noswapfile             " disable swap files
set expandtab              " insert spaces rather than tab for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4              " the visible width of tabs
set softtabstop=4          " edit as if the tabs are 4 characters wide
set shiftwidth=4           " number of spaces to use for indent and unindent
set shiftround             " round indent to a multiple of 'shiftwidth'
set number                 " show line numbers
set nocompatible           " not compatible with vi
set colorcolumn=121        " column delimiter
