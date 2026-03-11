#!/bin/bash
# ============================================================
#  cmake install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing cmake..."
sudo apt install -y cmake

echo "==> Installing mkproject command..."
sudo cp "$SCRIPT_DIR/mkproject.sh" /usr/local/bin/mkproject
sudo chmod +x /usr/local/bin/mkproject

echo ""
echo "✓ cmake installed!"
echo ""
echo "  Create a new C++ project anywhere with:"
echo "    mkproject myproject"
