#!/bin/bash
# ============================================================
#  dotfiles master install script
#  Usage: ./install.sh [module]
#  Examples:
#    ./install.sh          # shows menu
#    ./install.sh all      # installs everything
#    ./install.sh vim/base
#    ./install.sh vim/c-cpp
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODULES=(
  "vim/base"
  "vim/c-cpp"
)

install_module() {
  local module=$1
  local path="$SCRIPT_DIR/$module/install.sh"

  if [ ! -f "$path" ]; then
    echo "✗ Module not found: $module"
    exit 1
  fi

  chmod +x "$path"
  bash "$path"
}

# Called with argument
if [ -n "$1" ]; then
  if [ "$1" = "all" ]; then
    for m in "${MODULES[@]}"; do
      install_module "$m"
    done
  else
    install_module "$1"
  fi
  exit 0
fi

# Interactive menu
echo "==============================="
echo "  dotfiles installer"
echo "==============================="
echo ""
echo "Available modules:"
for i in "${!MODULES[@]}"; do
  echo "  $((i+1))) ${MODULES[$i]}"
done
echo "  a) All"
echo "  q) Quit"
echo ""
read -rp "Choose: " choice

case $choice in
  a) for m in "${MODULES[@]}"; do install_module "$m"; done ;;
  q) exit 0 ;;
  *) 
    idx=$((choice-1))
    if [ -n "${MODULES[$idx]}" ]; then
      install_module "${MODULES[$idx]}"
    else
      echo "Invalid choice"
      exit 1
    fi
    ;;
esac
