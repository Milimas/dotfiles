" ============================================================
"  WEB VIMRC — extends vim/base (JS/TS/HTML/CSS)
"  Part of: dotfiles/vim/web
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

" ── Web specific ──────────────────────────────────────────
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'pangloss/vim-javascript'          " JS syntax
Plug 'leafgarland/typescript-vim'       " TS syntax
Plug 'maxmellon/vim-jsx-pretty'         " JSX syntax
Plug 'ap/vim-css-color'                 " CSS color preview
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'html', 'json'] }

call plug#end()

" ── ALE ──────────────────────────────────────────────────
let g:ale_linters = {
  \ 'javascript': ['eslint', 'tsserver'],
  \ 'typescript': ['eslint', 'tsserver'],
  \ 'html': ['htmlhint'],
  \ 'css': ['stylelint']
  \ }
let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'css': ['prettier'],
  \ 'html': ['prettier']
  \ }
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 'auto'

" ── Prettier ─────────────────────────────────────────────
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" ── LSP keymaps ──────────────────────────────────────────
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap <F2> :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>
nnoremap <F3> :Prettier<CR>
