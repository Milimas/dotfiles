# vim/c-cpp

C/C++ development setup for Vim. Builds on top of `vim/base`.

## What's installed

| Plugin | Purpose |
|---|---|
| `dense-analysis/ale` | Linting and auto-fix on save |
| `prabirshrestha/vim-lsp` | LSP client for clangd |
| `prabirshrestha/asyncomplete.vim` | Autocompletion |
| `mattn/vim-lsp-settings` | Auto-configures clangd |
| `rhysd/vim-clang-format` | Code formatting |

## Keymaps

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `F2` | Rename symbol |
| `F3` | Format file |
| `Space+ca` | Code actions |
| `]a` / `[a` | Next / previous warning |

## Install
```bash
chmod +x install.sh
./install.sh
```

## Per-project setup
```bash
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
ln -s build/compile_commands.json compile_commands.json
```
```

---

**`.gitignore`:**
```
.DS_Store
*.swp
*.swo
*~
