" ============================================================
"  C/C++ VIMRC — extends vim/base
"  Part of: dotfiles/vim/c-cpp
" ============================================================

source ~/.vim/base.vimrc

call plug#begin('~/.vim/plugged')

" ── Base plugins ─────────────────────────────────────────
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mg979/vim-visual-multi'

" ── C/C++ specific ───────────────────────────────────────
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'rhysd/vim-clang-format'

call plug#end()

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
