# tmux — Cheatsheet

> Prefix key is `Ctrl+a`

---

## Sessions

| Command | Action |
|---------|--------|
| `tmux new -s name` | Create named session |
| `tmux attach -t name` | Attach to session |
| `tmux ls` | List sessions |
| `Prefix + $` | Rename current session |
| `Prefix + d` | Detach from session |
| `Prefix + s` | Switch session interactively |

---

## Windows

| Key | Action |
|-----|--------|
| `Prefix + c` | Create new window |
| `Prefix + ,` | Rename window |
| `Prefix + n` | Next window |
| `Prefix + p` | Previous window |
| `Prefix + 1-9` | Switch to window by number |
| `Prefix + &` | Close window |

---

## Panes

| Key | Action |
|-----|--------|
| `Prefix + \|` | Split vertically (side by side) |
| `Prefix + -` | Split horizontally (top / bottom) |
| `Prefix + x` | Close current pane |
| `Prefix + z` | Toggle pane fullscreen |

---

## Pane Navigation

| Vim keys | Arrow keys | Action |
|----------|------------|--------|
| `Prefix + h` | `Prefix + ←` | Move left |
| `Prefix + j` | `Prefix + ↓` | Move down |
| `Prefix + k` | `Prefix + ↑` | Move up |
| `Prefix + l` | `Prefix + →` | Move right |

---

## Pane Resizing (vim mode only)

| Key | Action |
|-----|--------|
| `Prefix + H` | Resize left |
| `Prefix + J` | Resize down |
| `Prefix + K` | Resize up |
| `Prefix + L` | Resize right |

---

## Copy Mode

| Key | Action |
|-----|--------|
| `Prefix + Enter` | Enter copy mode |
| `v` | Start selection |
| `y` | Copy selection and exit |
| `Escape` | Exit copy mode |

---

## Other

| Key | Action |
|-----|--------|
| `Prefix + r` | Reload config |
| `Prefix + ?` | List all keybindings |
