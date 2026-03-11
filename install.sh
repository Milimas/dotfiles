#!/bin/bash
# ============================================================
#  dotfiles master installer
#  Remembers your choices in ~/.dotfiles_config
#  Re-run anytime to change selections
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$HOME/.dotfiles_config"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

config_get() {
  grep "^$1=" "$CONFIG_FILE" 2>/dev/null | cut -d= -f2
}

config_set() {
  if grep -q "^$1=" "$CONFIG_FILE" 2>/dev/null; then
    sed -i "s/^$1=.*/$1=$2/" "$CONFIG_FILE"
  else
    echo "$1=$2" >> "$CONFIG_FILE"
  fi
}

config_init() { touch "$CONFIG_FILE"; }

prompt_choice() {
  local question=$1 config_key=$2
  shift 2
  local options=("$@")
  local current
  current=$(config_get "$config_key")

  echo ""
  echo -e "${BOLD}$question${NC}"
  for i in "${!options[@]}"; do
    if [ "${options[$i]}" = "$current" ]; then
      echo -e "  ${GREEN}$((i+1))) ${options[$i]} (current)${NC}"
    else
      echo "  $((i+1))) ${options[$i]}"
    fi
  done

  read -rp "  Choice [Enter to keep current]: " choice
  if [ -z "$choice" ] && [ -n "$current" ]; then echo "$current"; return; fi
  local idx=$((choice-1))
  if [ -n "${options[$idx]}" ]; then
    config_set "$config_key" "${options[$idx]}"
    echo "${options[$idx]}"
  else
    echo "$current"
  fi
}

prompt_yn() {
  local question=$1 config_key=$2
  local current
  current=$(config_get "$config_key")

  echo ""
  if [ -n "$current" ]; then
    echo -e "${BOLD}$question${NC} (current: ${GREEN}$current${NC})"
  else
    echo -e "${BOLD}$question${NC}"
  fi
  read -rp "  [y/n, Enter to keep current]: " choice

  if [ -z "$choice" ] && [ -n "$current" ]; then
    [ "$current" = "y" ] && return 0 || return 1
  fi
  if [[ "$choice" =~ ^[Yy]$ ]]; then config_set "$config_key" "y"; return 0
  else config_set "$config_key" "n"; return 1; fi
}

install_module() {
  local module=$1
  local path="$SCRIPT_DIR/$module/install.sh"
  if [ ! -f "$path" ]; then echo -e "${RED}✗ Not found: $module${NC}"; return 1; fi
  chmod +x "$path"
  bash "$path"
}

# ── Main ─────────────────────────────────────────────────
config_init

echo ""
echo -e "${BOLD}===============================${NC}"
echo -e "${BOLD}      dotfiles installer       ${NC}"
echo -e "${BOLD}===============================${NC}"
echo -e "${YELLOW}  Config: $CONFIG_FILE${NC}"
echo -e "${YELLOW}  Re-run anytime to change.${NC}"

echo ""
echo -e "${BOLD}── Select modules ──${NC}"

prompt_yn "Install vim/base?"     "install_vim_base"   && INSTALL_VIM_BASE=y
prompt_yn "Install vim/c-cpp?"   "install_vim_cpp"    && INSTALL_VIM_CPP=y
prompt_yn "Install vim/python?"  "install_vim_python" && INSTALL_VIM_PYTHON=y
prompt_yn "Install vim/web?"     "install_vim_web"    && INSTALL_VIM_WEB=y
prompt_yn "Install tmux?"        "install_tmux"       && INSTALL_TMUX=y
prompt_yn "Install fonts?"       "install_fonts"      && INSTALL_FONTS=y
prompt_yn "Install node?"        "install_node"       && INSTALL_NODE=y
prompt_yn "Install cmake?"       "install_cmake"      && INSTALL_CMAKE=y
prompt_yn "Install ssh config?"  "install_ssh"        && INSTALL_SSH=y

echo ""
echo -e "${BOLD}── Configure options ──${NC}"

[ "${INSTALL_VIM_PYTHON}" = "y" ] && PYTHON_LSP=$(prompt_choice   "Python LSP:"        "python_lsp"   "pyright" "pylsp") && export PYTHON_LSP
[ "${INSTALL_NODE}" = "y" ]       && NODE_MANAGER=$(prompt_choice "Node manager:"      "node_manager" "fnm" "nvm")       && export NODE_MANAGER
[ "${INSTALL_FONTS}" = "y" ]      && FONT=$(prompt_choice         "Nerd Font:"         "font"         "JetBrainsMono" "FiraCode" "Hack" "CascadiaCode") && export FONT
[ "${INSTALL_TMUX}" = "y" ]       && TMUX_KEYS=$(prompt_choice    "Tmux nav keys:"     "tmux_keys"    "vim (hjkl)" "arrow keys") && export TMUX_KEYS

echo ""
echo -e "${BOLD}── Installing ──${NC}"

[ "${INSTALL_VIM_BASE}" = "y" ]   && install_module "vim/base"
[ "${INSTALL_VIM_CPP}" = "y" ]    && install_module "vim/c-cpp"
[ "${INSTALL_VIM_PYTHON}" = "y" ] && install_module "vim/python"
[ "${INSTALL_VIM_WEB}" = "y" ]    && install_module "vim/web"
[ "${INSTALL_TMUX}" = "y" ]       && install_module "tmux"
[ "${INSTALL_FONTS}" = "y" ]      && install_module "fonts"
[ "${INSTALL_NODE}" = "y" ]       && install_module "node"
[ "${INSTALL_CMAKE}" = "y" ]      && install_module "cmake"
[ "${INSTALL_SSH}" = "y" ]        && install_module "ssh"

echo ""
echo -e "${GREEN}${BOLD}✓ Done! Choices saved to $CONFIG_FILE${NC}"
echo -e "${YELLOW}  Run ./install.sh again anytime to reconfigure.${NC}"
