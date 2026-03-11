" ============================================================
"  PYTHON VIMRC — extends vim/base
"  Part of: dotfiles/vim/python
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

" ── Python specific ───────────────────────────────────────
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'Vimjas/vim-python-pep8-indent'   " better python indentation
Plug 'jeetsukumaran/vim-pythonsense'   " python text objects

call plug#end()

" ── ALE ──────────────────────────────────────────────────
let g:ale_linters = {'python': ['PYTHON_LSP_PLACEHOLDER']}
let g:ale_fixers  = {'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 'auto'

" ── LSP keymaps ──────────────────────────────────────────
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap <F2> :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>

" ── Python specific settings ─────────────────────────────
let g:ale_python_black_options = '--line-length 88'
