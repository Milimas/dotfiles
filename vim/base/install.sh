#!/bin/bash
# ============================================================
#  vim/base install script
#  Installs: vim-gtk3, vim-plug, base .vimrc
# ============================================================

set -e

# ── Guard: skip if already installed ─────────────────────
if [ -f "$HOME/.vim/autoload/plug.vim" ] && [ "${FORCE_REINSTALL:-}" != "1" ]; then
  echo "==> vim/base already installed, skipping."
  echo "    (set FORCE_REINSTALL=1 to reinstall)"
  exit 0
fi

echo "==> Installing vim/base..."

echo "==> Installing system packages..."
sudo apt update -q
sudo apt install -y vim-gtk3 curl git xclip nodejs npm

echo "==> Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "==> Copying .vimrc..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f ~/.vimrc ]; then
  echo "==> Backing up existing .vimrc to ~/.vimrc.backup"
  cp ~/.vimrc ~/.vimrc.backup
fi

cp "$SCRIPT_DIR/.vimrc" ~/.vimrc

echo "==> Installing Vim plugins..."
vim +PlugInstall +qall

echo ""
echo "✓ vim/base installed successfully!"
