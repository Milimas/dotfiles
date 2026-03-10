# vim/base

General purpose Vim setup. Works for any language. The `vim/c-cpp` setup builds on top of this.

## What's installed

| Plugin | Purpose |
|---|---|
| `preservim/nerdtree` | File explorer (`Ctrl+n`) |
| `junegunn/fzf` | Fuzzy file finder (`Ctrl+p`) |
| `tpope/vim-fugitive` | Git integration |
| `vim-airline` | Status line |

## Keymaps

| Key | Action |
|---|---|
| `Ctrl+n` | Toggle file explorer |
| `Ctrl+p` | Fuzzy file finder |
| `Space+fg` | Search inside files |
| `Space+h` | Clear search highlight |
| `Space+m` | Maximize current split |
| `Space+=` | Restore equal splits |
| `Ctrl+h/j/k/l` | Navigate between splits |

## Install
```bash
chmod +x install.sh
./install.sh
```
