# vim/python — Cheatsheet

> Python LSP, black formatter, and isort. Extends vim/base.

---

## Code Navigation (LSP)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Hover documentation |
| `F2` | Rename symbol |
| `Space+ca` | Code actions |

---

## Formatting

| Key | Action |
|-----|--------|
| `:ALEFix` | Manually run black + isort |

> Auto-formats and sorts imports on save.

---

## LSP Options

| Option | Description |
|--------|-------------|
| `pyright` | Microsoft — faster, stricter type checking |
| `pylsp` | Open source — more flexible, supports more plugins |

---

## Tips

- `black` formats with a default line length of 88 characters
- `isort` automatically sorts and groups your imports
- Change LSP by re-running `./install.sh` from the dotfiles root
