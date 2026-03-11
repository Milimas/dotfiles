" ============================================================
"  BASE VIMRC — general purpose
"  Part of: dotfiles/vim/base
" ============================================================

call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Multi Cursor
Plug 'mg979/vim-visual-multi'

call plug#end()

" ── General ──────────────────────────────────────────────
set number
set relativenumber
set tabstop=4 shiftwidth=4
set expandtab
set smartindent
set nowrap
set scrolloff=8
set signcolumn=yes
set updatetime=100
set clipboard=unnamedplus

" ── Appearance ───────────────────────────────────────────
syntax on
filetype plugin indent on
set cursorline
set termguicolors
highlight CursorLine cterm=NONE ctermbg=235 gui=NONE guibg=#2e2e2e

" ── Search ───────────────────────────────────────────────
set incsearch
set hlsearch
set ignorecase
set smartcase

" ── Keymaps ──────────────────────────────────────────────
let mapleader = " "

nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>m <C-w>\| <C-w>_
nnoremap <leader>= <C-w>=
