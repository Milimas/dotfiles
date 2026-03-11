# fonts — Cheatsheet

> Installs a Nerd Font to `~/.local/share/fonts/`

---

## Available Fonts

| Font | Style |
|------|-------|
| `JetBrainsMono` | Clean, great for code |
| `FiraCode` | Popular, has ligatures |
| `Hack` | Minimal, very readable |
| `CascadiaCode` | Microsoft, modern feel |

---

## After Install

Set your terminal font to the installed Nerd Font. The font name to use is `<FontName> Nerd Font Mono`.

| Terminal | Where to set font |
|----------|------------------|
| GNOME Terminal | Preferences → Profile → Text → Custom font |
| Konsole | Settings → Edit Current Profile → Appearance → Font |
| Alacritty | `~/.config/alacritty/alacritty.yml` → `font.normal.family` |
| Kitty | `~/.config/kitty/kitty.conf` → `font_family` |
| Terminator | Preferences → Profiles → General → Font |

---

## Why Nerd Fonts?

Nerd Fonts patch regular coding fonts with thousands of extra icons (from Font Awesome, Devicons, etc.). Without them, vim-airline and tmux statusbar show broken placeholder characters instead of icons.

---

## Change Font

Re-run the installer and pick a different one:

```bash
./install.sh
```

Your previous choice is shown as `current`. Type a number to switch.
