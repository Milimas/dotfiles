#!/bin/bash
# ============================================================
#  vim/python install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/../base"

echo "==> Installing vim/python..."

bash "$BASE_DIR/install.sh"

sudo apt install -y python3 python3-pip

LSP="${PYTHON_LSP:-}"
if [ -z "$LSP" ]; then
  echo ""
  echo "Which Python LSP?"
  echo "  1) pyright (faster, Microsoft)"
  echo "  2) pylsp (open source)"
  read -rp "  Choice [1]: " choice
  case $choice in
    2) LSP="pylsp" ;;
    *) LSP="pyright" ;;
  esac
fi

echo "==> Installing $LSP..."
if [ "$LSP" = "pyright" ]; then
  sudo apt install -y nodejs npm
  sudo npm install -g pyright
else
  pip3 install python-lsp-server --break-system-packages
fi

echo "==> Installing black and isort..."
pip3 install black isort --break-system-packages

cp ~/.vimrc ~/.vim/base.vimrc 2>/dev/null || true
sed "s/PYTHON_LSP_PLACEHOLDER/$LSP/" "$SCRIPT_DIR/.vimrc" > ~/.vimrc

vim +PlugInstall +qall

echo ""
echo "✓ vim/python installed with $LSP!"
echo "  Open a .py file and run :LspInstallServer"
