# vim/c-cpp — Cheatsheet

> C/C++ LSP, linting, and formatting. Extends vim/base.

---

## Code Navigation (LSP)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Hover documentation |
| `F2` | Rename symbol across project |
| `Space+ca` | Show code actions |

---

## Linting (ALE)

| Key | Action |
|-----|--------|
| `]a` | Jump to next warning / error |
| `[a` | Jump to previous warning / error |
| `:ALEFix` | Apply fix manually |
| `:ALEDetail` | Show full error detail |
| `:ALEInfo` | Show ALE status and config |

> Auto-fixes on save via `ale_fix_on_save = 1`

---

## Formatting

| Key | Action |
|-----|--------|
| `F3` | Format file with clang-format |

---

## Project Setup

```bash
# Generate compile_commands.json so clangd understands your project
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
ln -s build/compile_commands.json compile_commands.json
```

```vim
" First time on a new machine — install clangd LSP server
:LspInstallServer
```

---

## .clangd config

```yaml
CompileFlags:
  CompilationDatabase: build/   # where compile_commands.json lives
```

Place this in your project root to override the global one.
