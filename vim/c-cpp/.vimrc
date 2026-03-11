" ============================================================
"  C/C++ VIMRC
"  Part of: dotfiles/vim/c-cpp
" ============================================================

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mg979/vim-visual-multi'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'rhysd/vim-clang-format'

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
syntax on
filetype plugin indent on
set cursorline
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
nnoremap <leader>t :vert terminal<CR>

" ── ALE ──────────────────────────────────────────────────
let g:ale_linters = {'c': ['clangd'], 'cpp': ['clangd']}
let g:ale_fixers  = {'c': ['clang-format'], 'cpp': ['clang-format']}
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 'auto'

" ── LSP keymaps ──────────────────────────────────────────
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap <F2> :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>

" ── Clang format ─────────────────────────────────────────
nnoremap <F3> :ClangFormat<CR>
