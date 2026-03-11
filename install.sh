#!/bin/bash
# ============================================================
#  dotfiles master installer
#  Remembers your choices in ~/.dotfiles_config
#  Re-run anytime to change selections
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$HOME/.dotfiles_config"

# ── Colors ───────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ── Config helpers ────────────────────────────────────────
config_get() { grep "^$1=" "$CONFIG_FILE" 2>/dev/null | cut -d= -f2; }
config_set() {
  if grep -q "^$1=" "$CONFIG_FILE" 2>/dev/null; then
    sed -i "s/^$1=.*/$1=$2/" "$CONFIG_FILE"
  else
    echo "$1=$2" >> "$CONFIG_FILE"
  fi
}
config_init() { touch "$CONFIG_FILE"; }

# ── Prompt: yes/no ────────────────────────────────────────
prompt_yn() {
  local question=$1
  local config_key=$2
  local current
  current=$(config_get "$config_key")

  local hint=""
  if [ "$current" = "y" ]; then
    hint=" ${DIM}[current: Yes]${NC}"
  elif [ "$current" = "n" ]; then
    hint=" ${DIM}[current: No]${NC}"
  fi

  echo -e "  ${BOLD}$question${NC}$hint"
  read -rp "    Install? [Y/n]: " choice

  if [ -z "$choice" ]; then
    if [ "$current" = "n" ]; then
      config_set "$config_key" "n"
      return 1
    fi
    config_set "$config_key" "y"
    return 0
  fi

  if [[ "$choice" =~ ^[Yy]$ ]]; then
    config_set "$config_key" "y"
    return 0
  else
    config_set "$config_key" "n"
    return 1
  fi
}

# ── Prompt: multiple choice ───────────────────────────────
# Prints UI to stderr, echoes result to stdout
prompt_choice() {
  local question=$1
  local description=$2
  local config_key=$3
  shift 3
  local options=("$@")
  local current
  current=$(config_get "$config_key")

  echo -e "" >&2
  echo -e "  ${BOLD}$question${NC}" >&2
  echo -e "  ${DIM}$description${NC}" >&2
  echo "" >&2
  for i in "${!options[@]}"; do
    if [ "${options[$i]}" = "$current" ]; then
      echo -e "    ${GREEN}$((i+1))) ${options[$i]}  ✓ current${NC}" >&2
    else
      echo "    $((i+1))) ${options[$i]}" >&2
    fi
  done
  echo "" >&2

  read -rp "    Your choice [Enter to keep current]: " choice >&2

  if [ -z "$choice" ] && [ -n "$current" ]; then
    echo "$current"
    return
  fi

  local idx=$((choice-1))
  if [ -n "${options[$idx]}" ]; then
    config_set "$config_key" "${options[$idx]}"
    echo "${options[$idx]}"
  else
    echo "$current"
  fi
}

install_module() {
  local module=$1
  local path="$SCRIPT_DIR/$module/install.sh"
  if [ ! -f "$path" ]; then
    echo "  ✗ Module not found: $module"
    return 1
  fi
  chmod +x "$path"
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${CYAN}  Installing: $module${NC}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  bash "$path"
}

# ── Main ─────────────────────────────────────────────────
config_init

echo ""
echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║         dotfiles installer           ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"
echo -e "  ${DIM}Choices saved to: $CONFIG_FILE${NC}"
echo -e "  ${DIM}Re-run anytime to change.${NC}"

# ── Step 1: Select modules ────────────────────────────────
echo ""
echo -e "${BOLD}━━ Step 1: Choose what to install ━━━━━━${NC}"
echo -e "${DIM}  Press Enter to accept Yes (default).${NC}"
echo ""

echo -e "${YELLOW}  ── Vim ──────────────────────────────${NC}"
prompt_yn "vim/base       — core Vim setup (NERDTree, FZF, git, statusline)" "install_vim_base"   && INSTALL_VIM_BASE=y
prompt_yn "vim/c-cpp      — C/C++ LSP, linting, clang-format"               "install_vim_cpp"    && INSTALL_VIM_CPP=y
prompt_yn "vim/python     — Python LSP, black formatter, isort"              "install_vim_python" && INSTALL_VIM_PYTHON=y
prompt_yn "vim/web        — JS/TS LSP, prettier, eslint, JSX support"        "install_vim_web"    && INSTALL_VIM_WEB=y

echo ""
echo -e "${YELLOW}  ── Tools ────────────────────────────${NC}"
prompt_yn "tmux           — terminal multiplexer with custom config"         "install_tmux"       && INSTALL_TMUX=y
prompt_yn "fonts          — Nerd Font for icons in vim-airline and tmux"     "install_fonts"      && INSTALL_FONTS=y
prompt_yn "node           — Node.js version manager + TS playground"         "install_node"       && INSTALL_NODE=y
prompt_yn "cmake          — cmake + mkproject command to scaffold C++ apps"  "install_cmake"      && INSTALL_CMAKE=y
prompt_yn "ssh            — SSH config template for GitHub, VPS, jump hosts" "install_ssh"        && INSTALL_SSH=y

# ── Step 2: Configure options ─────────────────────────────
echo ""
echo -e "${BOLD}━━ Step 2: Configure your options ━━━━━━${NC}"

SHOW_OPTIONS=false
[ "${INSTALL_VIM_PYTHON}" = "y" ] && SHOW_OPTIONS=true
[ "${INSTALL_NODE}" = "y" ]       && SHOW_OPTIONS=true
[ "${INSTALL_FONTS}" = "y" ]      && SHOW_OPTIONS=true
[ "${INSTALL_TMUX}" = "y" ]       && SHOW_OPTIONS=true

if [ "$SHOW_OPTIONS" = "false" ]; then
  echo -e "  ${DIM}No options needed for your selected modules.${NC}"
fi

if [ "${INSTALL_VIM_PYTHON}" = "y" ]; then
  PYTHON_LSP=$(prompt_choice \
    "Python language server" \
    "Provides autocompletion, go-to-definition, and error checking for .py files." \
    "python_lsp" \
    "pyright (Microsoft — faster, stricter)" \
    "pylsp (open source — more flexible)")
  export PYTHON_LSP
fi

if [ "${INSTALL_NODE}" = "y" ]; then
  NODE_MANAGER=$(prompt_choice \
    "Node.js version manager" \
    "Lets you install and switch between multiple Node.js versions." \
    "node_manager" \
    "fnm (fast, written in Rust — recommended)" \
    "nvm (most popular, shell-based)")
  export NODE_MANAGER
fi

if [ "${INSTALL_FONTS}" = "y" ]; then
  FONT=$(prompt_choice \
    "Nerd Font" \
    "Required for icons in vim-airline and tmux statusbar. Set this font in your terminal after install." \
    "font" \
    "JetBrainsMono" \
    "FiraCode" \
    "Hack" \
    "CascadiaCode")
  export FONT
fi

if [ "${INSTALL_TMUX}" = "y" ]; then
  TMUX_KEYS=$(prompt_choice \
    "Tmux pane navigation style" \
    "How you switch between split panes. Vim-style uses h/j/k/l — recommended if you use Vim." \
    "tmux_keys" \
    "vim (hjkl)" \
    "arrow keys")
  export TMUX_KEYS
fi

# ── Step 3: Install ───────────────────────────────────────
echo ""
echo -e "${BOLD}━━ Step 3: Installing ━━━━━━━━━━━━━━━━━━${NC}"

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
echo -e "${GREEN}${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║  ✓ Installation complete!            ║${NC}"
echo -e "${GREEN}${BOLD}╚══════════════════════════════════════╝${NC}"
echo -e "  ${DIM}Run ./install.sh again anytime to change anything.${NC}"
echo ""
