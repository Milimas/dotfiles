# vim/web — Cheatsheet

> JS/TS LSP, prettier, eslint, JSX support. Extends vim/base.

---

## Code Navigation (LSP)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `F2` | Rename symbol |
| `Space+ca` | Code actions |

---

## Formatting

| Key | Action |
|-----|--------|
| `F3` | Format with prettier |
| `:ALEFix` | Manually trigger prettier + eslint |

> Auto-formats on save for JS, TS, CSS, HTML.

---

## Supported Languages

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
| JavaScript | tsserver | prettier | eslint |
| TypeScript | tsserver | prettier | eslint |
| JSX / TSX | tsserver | prettier | eslint |
| CSS | — | prettier | stylelint |
| HTML | — | prettier | htmlhint |
| JSON | — | prettier | — |
