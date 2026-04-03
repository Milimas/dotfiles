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

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

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

" True color support
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#3a3a3a

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
nnoremap <leader>md :MarkdownPreview<CR>

" ── Vimdiff mode ─────────────────────────────────────────
if &diff
    " better diff display
    set diffopt=filler,vertical,iwhite,internal,algorithm:histogram
    set wrap
    set linebreak
    set nolist
    set nocursorline
    set foldmethod=diff
    set scrollbind
    set cursorbind

    " make split vertical for git difftool
    set diffopt+=vertical

    " readable diff colors
    highlight DiffAdd      cterm=bold ctermfg=NONE ctermbg=22  gui=bold guibg=#294436
    highlight DiffDelete   cterm=bold ctermfg=NONE ctermbg=52  gui=bold guibg=#51202a
    highlight DiffChange   cterm=bold ctermfg=NONE ctermbg=17  gui=bold guibg=#1f2a44
    highlight DiffText     cterm=bold ctermfg=NONE ctermbg=24  gui=bold guibg=#365f8c

    " column indicators
    highlight DiffAdded    ctermfg=2
    highlight DiffRemoved  ctermfg=1

    " make filler lines subtle
    highlight DiffLine     ctermbg=236 guibg=#2a2a2a

    " improve readability
    set colorcolumn=
    set number
    set relativenumber
endif
