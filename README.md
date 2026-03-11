# dotfiles

A modular collection of development environment setups. Pick and install only what you need. Re-run the installer anytime to change your selections.

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

The installer remembers your choices in `~/.dotfiles_config`. Re-run anytime to add or change modules.

## Modules

| Module | Description |
|---|---|
| `vim/base` | NERDTree, FZF, fugitive, airline, multi-cursor |
| `vim/c-cpp` | clangd, ALE, vim-lsp, asyncomplete, clang-format |
| `vim/python` | pyright or pylsp, black, isort |
| `vim/web` | tsserver, prettier, eslint, JSX/TS syntax |
| `tmux` | tmux config with vim or arrow key navigation |
| `fonts` | Nerd Fonts (JetBrainsMono, FiraCode, Hack, CascadiaCode) |
| `node` | fnm or nvm + Node LTS + TypeScript playground |
| `cmake` | cmake + `mkproject` command to scaffold C++ projects |
| `ssh` | SSH config template with GitHub, VPS, jump host examples |

## mkproject

After installing the `cmake` module, scaffold a new C++ project anywhere:

```bash
mkproject myengine
cd myengine
cmake --build build
./build/src/myengine
```

Creates a full CMake project with `compile_commands.json`, `.clangd`, `.gitignore`, and an initial git commit.
