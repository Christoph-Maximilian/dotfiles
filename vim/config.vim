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
Plug 'zchee/deoplete-jedi'                  " auto-completion for python
Plug 'lervag/vimtex'                        " auto-completion for vimtex
Plug 'autozimu/LanguageClient-neovim', {
    \ 'commit': 'ec4af74',
    \ 'do': 'bash install.sh',
    \ }                                     " languageserver
Plug 'itchyny/lightline.vim'                " bottom status bar
" Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	        " NERDTree git plugin
Plug 'justmao945/vim-clang'	   	            " nvim clang automation
Plug 'preservim/nerdcommenter'              " easy multiline commenting
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'sbdchd/neoformat'
call plug#end()

" Alternate map leader
let mapleader = ','
let g:mapleader = ','

"nvim-gdb
nmap <M-b> :GdbBreakpointToggle<CR>
autocmd VimEnter * nnoremap <leader>dd :GdbStart gdb<CR> <bar> i"test"

" Cursor History
"   - go to previous position: <C-O>
"   - go to next position: <C-I>

" Language server config
" Important: .compile_commands.json must be in root directory
let g:LanguageClient_serverCommands = {
  \ 'python': ['~/.local/bin/pyls'],
  \ 'cpp': ['~/.local/bin/ccls'], 
  \ 'tex': ['~/.cargo/bin/texlab'], 
  \ }

" Lanugage client shortcuts
let g:LanguageClient_autoStart = 1
set hidden
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

" reload language server after compiling
nnoremap <leader>lj :LanguageClientStop <CR>
nnoremap <leader>lk :LanguageClientStart <CR>

let g:deoplete#enable_at_startup = 1
" let g:deoplete#custom#source('LanguageClient', 'sorters', [])

" REMAPS: refer to https://stackoverflow.com/a/3776182
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Clang-Format
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_on_insert_leave = 0
" " vim-clang overrides clang-format command
let g:clang_enable_format_command = 0

" neoformat
let g:neoformat_enabled_python = ['autopep8']

" vimtex
let g:vimtex_complete_enabled = 1

" NERDTree nmap
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nmap <C-n> :NERDTreeToggle<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Window splits
nnoremap <leader>w <C-W>
nnoremap <leader>ws  :split<CR>
nnoremap <leader>w+ :exe "resize " . (winheight(0) * 12/10)<CR>
nnoremap <leader>w- :exe "resize " . (winheight(0) * 8/10)<CR>
nnoremap <leader>wv  :vsplit<CR>
nnoremap <leader>w< :exe "vertical resize " . (winwidth(0) * 12/10)<CR>
nnoremap <leader>w> :exe "vertical resize " . (winwidth(0) * 8/10)<CR>

" Deoplete suggestion navigation
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

" Code folding (https://vim.fandom.com/wiki/Folding)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" New fast compilation commands
:com -nargs=1 Deb :!mkdir debug & cd debug; cmake -DCMAKE_BUILD_TYPE=DEBUG ..; make <args>
:com -nargs=1 Rel :!mkdir release & cd release; cmake -DCMAKE_BUILD_TYPE=RELEASE ..; make <args>

" Trigger build using cmake
nmap <leader>cd :Deb<Space>
nmap <leader>cr :Rel<Space>

" Commenting Plugin
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 2

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Markdown Plugin
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0

" Create symlink to compile_commands
"nmap <leader>ln :!ln -s debug/compile_commands.json compile_commands.json

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
set foldlevel=99           " opens all folds up to the given level when opening file
set foldmethod=syntax      " use for cpp and c files, python uses indent
set list!                   " show all characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set guifont=Monaco:h20
" set colorscheme here
colorscheme gruvbox

" Remember folds when closing files
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" highlight todos
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', 'todo' -1)
augroup END

filetype plugin on

