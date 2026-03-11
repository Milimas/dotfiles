#!/bin/bash
# ============================================================
#  vim/web install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/../base"

echo "==> Installing vim/web..."

bash "$BASE_DIR/install.sh"

# Load fnm if available
FNM_BIN="$HOME/.local/share/fnm"
if [ -f "$FNM_BIN/fnm" ]; then
  export PATH="$FNM_BIN:$PATH"
  eval "$("$FNM_BIN/fnm" env)"
fi

# Load nvm if available
if [ -f "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  \. "$NVM_DIR/nvm.sh"
fi

# Install node via apt as fallback if still not found
if ! command -v node &>/dev/null; then
  echo "==> Node.js not found, installing via apt..."
  sudo apt install -y nodejs npm
fi

echo "==> Installing web tools..."
npm install -g typescript typescript-language-server prettier eslint htmlhint stylelint

cp ~/.vimrc ~/.vim/base.vimrc 2>/dev/null || true
cp "$SCRIPT_DIR/.vimrc" ~/.vimrc

vim +PlugInstall +qall

echo ""
echo "✓ vim/web installed!"
echo "  Open a .js or .ts file and run :LspInstallServer"
