#!/bin/bash
# ============================================================
#  tmux install script
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing tmux..."
sudo apt install -y tmux

KEYS="${TMUX_KEYS:-}"
if [ -z "$KEYS" ]; then
  echo ""
  echo "Tmux navigation keys?"
  echo "  1) vim (hjkl)"
  echo "  2) arrow keys"
  read -rp "  Choice [1]: " choice
  case $choice in
    2) KEYS="arrow keys" ;;
    *) KEYS="vim (hjkl)" ;;
  esac
fi

if [ -f ~/.tmux.conf ]; then
  cp ~/.tmux.conf ~/.tmux.conf.backup
  echo "==> Backed up existing .tmux.conf"
fi

cp "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf

if [ "$KEYS" = "vim (hjkl)" ]; then
  sed -i 's/# TMUX_KEYS_PLACEHOLDER/bind h select-pane -L\nbind j select-pane -D\nbind k select-pane -U\nbind l select-pane -R\nbind -r H resize-pane -L 5\nbind -r J resize-pane -D 5\nbind -r K resize-pane -U 5\nbind -r L resize-pane -R 5/' ~/.tmux.conf
else
  sed -i 's/# TMUX_KEYS_PLACEHOLDER/bind Left select-pane -L\nbind Down select-pane -D\nbind Up select-pane -U\nbind Right select-pane -R/' ~/.tmux.conf
fi

echo ""
echo "✓ tmux installed with $KEYS navigation!"
echo "  Prefix: Ctrl+a"
echo "  Split horizontal: Prefix + |"
echo "  Split vertical:   Prefix + -"
echo "  Reload config:    Prefix + r"
