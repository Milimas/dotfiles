# dotfiles

A modular collection of development environment setups. Each tool lives in its own folder so you can pick and install only what you need.

## Structure

```
dotfiles/
├── vim/
│   ├── base/         # General purpose Vim setup
│   └── c-cpp/        # C/C++ development on top of base
├── shell/            # Zsh/Bash configs (coming soon)
├── git/              # Git config and aliases (coming soon)
└── install.sh        # Install everything at once
```

## Quick Install

### Everything at once
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

### Just Vim base
```bash
cd vim/base
chmod +x install.sh
./install.sh
```

### Just Vim C/C++
```bash
cd vim/c-cpp
chmod +x install.sh
./install.sh
```
> Note: vim/c-cpp installs vim/base automatically as a dependency.

## What's included

| Setup | Description |
|---|---|
| `vim/base` | vim-plug, NERDTree, FZF, fugitive, airline |
| `vim/c-cpp` | clangd, ALE, vim-lsp, asyncomplete, clang-format |

## Requirements

- Debian/Ubuntu based system (uses `apt`)
- `git`, `curl` installed
