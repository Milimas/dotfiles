#!/bin/bash
# ============================================================
#  vim/base install script
#  Installs: vim-gtk3, vim-plug, base .vimrc
# ============================================================

set -e

echo "==> Installing vim/base..."

# Install dependencies
echo "==> Installing system packages..."
sudo apt update -qq
sudo apt install -y vim-gtk3 curl git xclip

# Install vim-plug
echo "==> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc
echo "==> Copying .vimrc..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f ~/.vimrc ]; then
  echo "==> Backing up existing .vimrc to ~/.vimrc.backup"
  cp ~/.vimrc ~/.vimrc.backup
fi

cp "$SCRIPT_DIR/.vimrc" ~/.vimrc

# Install plugins
echo "==> Installing Vim plugins..."
vim +PlugInstall +qall

echo ""
echo "✓ vim/base installed successfully!"
echo "  - Your old .vimrc was backed up to ~/.vimrc.backup (if it existed)"
