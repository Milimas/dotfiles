#!/bin/bash
# ============================================================
#  vim/web install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/../base"

echo "==> Installing vim/web..."

bash "$BASE_DIR/install.sh"

if ! command -v node &>/dev/null; then
  echo "==> Node.js not found, installing..."
  sudo apt install -y nodejs npm
fi

echo "==> Installing web tools..."
sudo npm install -g typescript typescript-language-server prettier eslint htmlhint stylelint

cp ~/.vimrc ~/.vim/base.vimrc 2>/dev/null || true
cp "$SCRIPT_DIR/.vimrc" ~/.vimrc

vim +PlugInstall +qall

echo ""
echo "✓ vim/web installed!"
echo "  Open a .js or .ts file and run :LspInstallServer"
