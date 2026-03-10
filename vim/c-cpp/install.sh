#!/bin/bash
# ============================================================
#  vim/c-cpp install script
#  Installs: base vim setup + C/C++ tools
#  Requires: vim/base (installed automatically)
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/../base"

echo "==> Installing vim/c-cpp..."

# Install base first
echo "==> Installing vim/base dependency..."
bash "$BASE_DIR/install.sh"

# Install C/C++ system packages
echo "==> Installing C/C++ packages..."
sudo apt install -y clangd clang-format cmake

# Copy c-cpp vimrc (overrides base)
echo "==> Copying C/C++ .vimrc..."

# Save base vimrc as base.vimrc so c-cpp config can source it
cp ~/.vimrc ~/.vim/base.vimrc

if [ -f ~/.vimrc ]; then
  cp ~/.vimrc ~/.vimrc.backup
fi

cp "$SCRIPT_DIR/.vimrc" ~/.vimrc

# Copy clangd config
echo "==> Copying .clangd config..."
cp "$SCRIPT_DIR/.clangd" ~/.clangd 2>/dev/null || true

# Install plugins
echo "==> Installing Vim plugins..."
vim +PlugInstall +qall

echo ""
echo "✓ vim/c-cpp installed successfully!"
echo ""
echo "Next steps:"
echo "  1. In your project root, run:"
echo "     cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
echo "     ln -s build/compile_commands.json compile_commands.json"
echo "  2. Open a .cpp file in Vim and run :LspInstallServer"
