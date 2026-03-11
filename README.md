# dotfiles

A modular collection of development environment setups. Pick and install only what you need. Re-run the installer anytime to change your selections.

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

Your choices are saved to `~/.dotfiles_config`. Re-run anytime to add or change modules.

## Modules

| Module | Description | Cheatsheet |
|--------|-------------|------------|
| `vim/base` | NERDTree, FZF, fugitive, airline, multi-cursor | [→](vim/base/CHEATSHEET.md) |
| `vim/c-cpp` | clangd, ALE, vim-lsp, asyncomplete, clang-format | [→](vim/c-cpp/CHEATSHEET.md) |
| `vim/python` | pyright or pylsp, black, isort | [→](vim/python/CHEATSHEET.md) |
| `vim/web` | tsserver, prettier, eslint, JSX/TS syntax | [→](vim/web/CHEATSHEET.md) |
| `tmux` | tmux config with vim or arrow key navigation | [→](tmux/CHEATSHEET.md) |
| `fonts` | Nerd Fonts (JetBrainsMono, FiraCode, Hack, CascadiaCode) | [→](fonts/CHEATSHEET.md) |
| `node` | fnm or nvm + Node LTS + TypeScript playground | [→](node/CHEATSHEET.md) |
| `cmake` | cmake + `mkproject` command to scaffold C++ projects | [→](cmake/CHEATSHEET.md) |
| `ssh` | SSH config template for GitHub, VPS, jump hosts | [→](ssh/CHEATSHEET.md) |

## mkproject

After installing the `cmake` module, scaffold a new C++ project anywhere:

```bash
mkproject myengine
cd myengine
cmake --build build
./build/src/myengine
```

Creates a full CMake project with `compile_commands.json`, `.clangd`, `.gitignore`, and an initial git commit.
