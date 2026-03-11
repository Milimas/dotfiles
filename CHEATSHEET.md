# dotfiles cheatsheet

Quick reference for all shortcuts, commands, and options across every module.

---

## Table of Contents

- [Vim — Base](#vim--base)
- [Vim — C/C++](#vim--cc)
- [Vim — Python](#vim--python)
- [Vim — Web](#vim--web)
- [Tmux](#tmux)
- [CMake / mkproject](#cmake--mkproject)
- [Node Playground](#node-playground)
- [SSH](#ssh)
- [Fonts](#fonts)

---

## Vim — Base

> Core setup shared by all vim modules.

### Navigation

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

### Editing

| Key | Action |
|-----|--------|
| `Ctrl+n` | Select word, keep pressing for next occurrence (multi-cursor) |
| `Ctrl+Up/Down` | Add cursor above / below |
| `c` | Change all selected words (while in multi-cursor mode) |
| `q` | Skip current multi-cursor selection |
| `Q` | Remove current cursor |

### General

| Key | Action |
|-----|--------|
| `Space+h` | Clear search highlight |
| `gg"+yG` | Copy entire file to clipboard |
| `"+yy` | Copy current line to clipboard |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `u` | Undo |
| `Ctrl+r` | Redo |

### NERDTree (when open)

| Key | Action |
|-----|--------|
| `o` | Open file / expand folder |
| `s` | Open file in vertical split |
| `i` | Open file in horizontal split |
| `m` | Open menu (create, rename, delete) |
| `r` | Refresh tree |
| `q` | Close NERDTree |

---

## Vim — C/C++

> Extends vim/base with LSP, linting, and formatting.

### Code Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Show hover documentation |
| `F2` | Rename symbol across project |
| `Space+ca` | Show code actions |

### Linting (ALE)

| Key | Action |
|-----|--------|
| `]a` | Jump to next warning/error |
| `[a` | Jump to previous warning/error |
| `:ALEFix` | Apply fix manually |
| `:ALEDetail` | Show full error detail |
| `:ALEInfo` | Show ALE status and config |

### Formatting

| Key | Action |
|-----|--------|
| `F3` | Format file with clang-format |

> Auto-formats on save via ALE (`ale_fix_on_save = 1`)

### Project Setup

```bash
# Generate compile_commands.json so clangd understands your project
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
ln -s build/compile_commands.json compile_commands.json
```

```vim
" First time on a new machine — install clangd LSP server
:LspInstallServer
```

### `.clangd` config

```yaml
CompileFlags:
  CompilationDatabase: build/   # where compile_commands.json lives
```

---

## Vim — Python

> Extends vim/base with Python LSP, black, and isort.

### Code Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `K` | Show hover documentation |
| `F2` | Rename symbol |
| `Space+ca` | Code actions |

### Formatting

> Auto-formats with `black` and sorts imports with `isort` on save.

| Key | Action |
|-----|--------|
| `:ALEFix` | Manually trigger black + isort |

### LSP options

| Option | Description |
|--------|-------------|
| `pyright` | Microsoft — faster, stricter type checking |
| `pylsp` | Open source — more flexible, more plugins |

---

## Vim — Web

> Extends vim/base with JS/TS LSP, prettier, and eslint.

### Code Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `F2` | Rename symbol |
| `Space+ca` | Code actions |

### Formatting

| Key | Action |
|-----|--------|
| `F3` | Format with prettier |

> Auto-formats on save via ALE for JS, TS, CSS, HTML.

### Supported languages

`javascript`, `typescript`, `jsx`, `tsx`, `html`, `css`, `json`

---

## Tmux

> Terminal multiplexer. Prefix key is `Ctrl+a`.

### Sessions

| Key | Action |
|-----|--------|
| `tmux new -s name` | Create named session |
| `tmux attach -t name` | Attach to session |
| `tmux ls` | List sessions |
| `Prefix + $` | Rename session |
| `Prefix + d` | Detach from session |

### Windows (tabs)

| Key | Action |
|-----|--------|
| `Prefix + c` | Create new window |
| `Prefix + ,` | Rename window |
| `Prefix + n` | Next window |
| `Prefix + p` | Previous window |
| `Prefix + 1-9` | Switch to window by number |
| `Prefix + &` | Close window |

### Panes (splits)

| Key | Action |
|-----|--------|
| `Prefix + \|` | Split vertically |
| `Prefix + -` | Split horizontally |
| `Prefix + x` | Close pane |
| `Prefix + z` | Zoom pane (toggle fullscreen) |

### Pane navigation

| Vim keys | Arrow keys | Action |
|----------|------------|--------|
| `Prefix + h` | `Prefix + ←` | Move left |
| `Prefix + j` | `Prefix + ↓` | Move down |
| `Prefix + k` | `Prefix + ↑` | Move up |
| `Prefix + l` | `Prefix + →` | Move right |

### Pane resizing (vim mode)

| Key | Action |
|-----|--------|
| `Prefix + H` | Resize left |
| `Prefix + J` | Resize down |
| `Prefix + K` | Resize up |
| `Prefix + L` | Resize right |

### Copy mode

| Key | Action |
|-----|--------|
| `Prefix + Enter` | Enter copy mode |
| `v` | Start selection |
| `y` | Copy selection |
| `Escape` | Exit copy mode |

### Other

| Key | Action |
|-----|--------|
| `Prefix + r` | Reload tmux config |
| `Prefix + ?` | List all keybindings |

---

## CMake / mkproject

### mkproject — scaffold a new C++ project

```bash
mkproject myproject
```

Creates this structure instantly:

```
myproject/
├── src/
│   └── main.cpp
├── include/
│   └── myproject/
├── tests/
├── cmake/
├── build/                     ← auto-generated
├── compile_commands.json      ← symlinked for clangd
├── CMakeLists.txt
├── .clangd
└── .gitignore
```

Also runs `cmake`, generates `compile_commands.json`, and creates the first git commit automatically.

### Build commands

```bash
cmake --build build            # build the project
./build/src/myproject          # run the executable
cmake --build build --clean-first  # clean build
```

### CMake flags

| Flag | Purpose |
|------|---------|
| `-DCMAKE_EXPORT_COMPILE_COMMANDS=1` | Generate compile_commands.json for clangd |
| `-DCMAKE_BUILD_TYPE=Debug` | Debug build with symbols |
| `-DCMAKE_BUILD_TYPE=Release` | Optimized release build |
| `-B build` | Put build files in `build/` folder |

---

## Node Playground

> Created at `~/node-playground` during install.

### npm scripts

| Command | Action |
|---------|--------|
| `npm start` | Run `src/index.js` |
| `npm run ts` | Run `src/index.ts` with ts-node |
| `npm run watch` | Watch and re-run JS on save |
| `npm run watch:ts` | Watch and re-run TS on save |

### Version manager

#### fnm (recommended)

```bash
fnm install 20          # install Node 20
fnm use 20              # switch to Node 20
fnm list                # list installed versions
fnm current             # show active version
```

#### nvm

```bash
nvm install 20          # install Node 20
nvm use 20              # switch to Node 20
nvm ls                  # list installed versions
nvm current             # show active version
```

---

## SSH

> Config lives at `~/.ssh/config`.

### Generate a new key

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/id_github
```

### Add key to ssh-agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github
```

### Add to GitHub

```bash
cat ~/.ssh/id_github.pub
# Copy output → GitHub → Settings → SSH keys → New SSH key
```

### Config file structure

```
~/.ssh/config
├── Host *              — global defaults (keep-alive, key isolation)
├── Host github.com     — personal GitHub
├── Host github-work    — work GitHub (uses different key)
├── Host myserver       — VPS / remote machine
└── Host internal       — machine behind a jump host (bastion)
```

### Multiple GitHub accounts

```bash
# Clone with work account
git clone git@github-work:org/repo.git

# Set remote for existing repo
git remote set-url origin git@github-work:org/repo.git
```

---

## Fonts

> Installs a Nerd Font to `~/.local/share/fonts/`.

### After install

Set your terminal emulator font to the installed Nerd Font. Examples:

| Terminal | How to set font |
|----------|----------------|
| Alacritty | `~/.config/alacritty/alacritty.yml` → `font.normal.family` |
| Kitty | `~/.config/kitty/kitty.conf` → `font_family` |
| GNOME Terminal | Preferences → Profile → Text → Custom font |
| Konsole | Settings → Edit Current Profile → Appearance → Font |

### Available fonts

| Font | Style |
|------|-------|
| `JetBrainsMono` | Clean, great for code |
| `FiraCode` | Popular, has ligatures |
| `Hack` | Minimal, very readable |
| `CascadiaCode` | Microsoft, modern feel |

---

## Installer

```bash
./install.sh            # interactive menu, remembers choices
```

Choices are saved to `~/.dotfiles_config`. Re-run anytime to add or change modules — previous selections show as `current`.
