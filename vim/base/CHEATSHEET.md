# vim/base — Cheatsheet

> Core Vim setup shared by all vim modules.

---

## Navigation

| Key | Action |
|-----|--------|
| `Ctrl+e` | Toggle file explorer (NERDTree) |
| `Ctrl+p` | Fuzzy file finder (FZF) |
| `Space+fg` | Search text inside files (ripgrep) |
| `Ctrl+h` | Move to left split |
| `Ctrl+j` | Move to split below |
| `Ctrl+k` | Move to split above |
| `Ctrl+l` | Move to right split |
| `Space+m` | Maximize current split |
| `Space+=` | Restore equal split sizes |

---

## Multi-cursor

| Key | Action |
|-----|--------|
| `Ctrl+n` | Select word under cursor, keep pressing for next occurrence |
| `Ctrl+Up/Down` | Add cursor above / below |
| `c` | Change all selected words simultaneously |
| `q` | Skip current selection, go to next |
| `Q` | Remove current cursor |

---

## Editing

| Key | Action |
|-----|--------|
| `Space+h` | Clear search highlight |
| `yy` | Copy current line to clipboard |
| `gg yG` | Copy entire file to clipboard |
| `p` | Paste |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |

---

## NERDTree

| Key | Action |
|-----|--------|
| `o` | Open file / expand folder |
| `s` | Open in vertical split |
| `i` | Open in horizontal split |
| `m` | Menu (create, rename, delete) |
| `r` | Refresh tree |
| `q` | Close NERDTree |

---

## FZF

| Key | Action |
|-----|--------|
| `Ctrl+p` | Open file finder |
| `Ctrl+j/k` | Navigate results |
| `Enter` | Open file |
| `Ctrl+t` | Open in new tab |
| `Ctrl+x` | Open in horizontal split |
| `Ctrl+v` | Open in vertical split |
