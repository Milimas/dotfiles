#!/bin/bash
# ============================================================
#  ssh install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up SSH config..."

mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ -f ~/.ssh/config ]; then
  cp ~/.ssh/config ~/.ssh/config.backup
  echo "==> Backed up existing ~/.ssh/config"
fi

cp "$SCRIPT_DIR/config" ~/.ssh/config
chmod 600 ~/.ssh/config

echo ""
echo "✓ SSH config installed at ~/.ssh/config"
echo ""
echo "  Edit it to add your hosts:"
echo "    vim ~/.ssh/config"
echo ""
echo "  Generate a new key:"
echo "    ssh-keygen -t ed25519 -C 'your@email.com' -f ~/.ssh/id_github"
echo ""
echo "  Add to ssh-agent:"
echo "    ssh-add ~/.ssh/id_github"
