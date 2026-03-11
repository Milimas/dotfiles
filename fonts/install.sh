#!/bin/bash
# ============================================================
#  fonts install script — Nerd Fonts
# ============================================================

set -e

echo "==> Installing Nerd Font..."

FONT="${FONT:-}"
if [ -z "$FONT" ]; then
  echo ""
  echo "Which Nerd Font?"
  echo "  1) JetBrainsMono"
  echo "  2) FiraCode"
  echo "  3) Hack"
  echo "  4) CascadiaCode"
  read -rp "  Choice [1]: " choice
  case $choice in
    2) FONT="FiraCode" ;;
    3) FONT="Hack" ;;
    4) FONT="CascadiaCode" ;;
    *) FONT="JetBrainsMono" ;;
  esac
fi

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

VERSION="v3.2.1"
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$VERSION/${FONT}.zip"

echo "==> Downloading $FONT Nerd Font..."
TMP=$(mktemp -d)
curl -fLo "$TMP/${FONT}.zip" "$URL"

echo "==> Installing..."
unzip -o "$TMP/${FONT}.zip" -d "$FONT_DIR/${FONT}" '*.ttf' 2>/dev/null || \
unzip -o "$TMP/${FONT}.zip" -d "$FONT_DIR/${FONT}" '*.otf' 2>/dev/null

fc-cache -fv "$FONT_DIR" > /dev/null

rm -rf "$TMP"

echo ""
echo "✓ $FONT Nerd Font installed!"
echo "  Set your terminal font to: $FONT Nerd Font Mono"
