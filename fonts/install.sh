#!/bin/bash
# ============================================================
#  fonts install script — Nerd Fonts
#  Downloads and installs a Nerd Font, then automatically
#  sets it in your terminal emulator.
# ============================================================

set -e

echo "==> Installing Nerd Font..."
echo "    This script will:"
echo "      1. Download and install your chosen Nerd Font"
echo "      2. Auto-detect your terminal and set the font"
echo "      3. Fix broken icons in vim-airline and tmux"
echo ""

# ── Font selection ────────────────────────────────────────
FONT="${FONT:-}"
if [ -z "$FONT" ]; then
  echo "Which Nerd Font would you like to install?"
  echo "  (All include icons for vim-airline and tmux statusbar)"
  echo ""
  echo "  1) JetBrainsMono  — clean, excellent readability"
  echo "  2) FiraCode        — popular, includes ligatures (→ != >=)"
  echo "  3) Hack            — minimal, very readable"
  echo "  4) CascadiaCode    — modern, from Microsoft"
  echo ""
  read -rp "  Choice [1]: " choice
  case $choice in
    2) FONT="FiraCode" ;;
    3) FONT="Hack" ;;
    4) FONT="CascadiaCode" ;;
    *) FONT="JetBrainsMono" ;;
  esac
fi

# ── Font name mapping (what each terminal calls the font) ─
case "$FONT" in
  JetBrainsMono) FONT_FAMILY="JetBrainsMono Nerd Font Mono" ;;
  FiraCode)      FONT_FAMILY="FiraCode Nerd Font Mono" ;;
  Hack)          FONT_FAMILY="Hack Nerd Font Mono" ;;
  CascadiaCode)  FONT_FAMILY="CaskaydiaCove Nerd Font Mono" ;;
esac

FONT_SIZE=12

# ── Download and install font ─────────────────────────────
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

VERSION="v3.2.1"
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$VERSION/${FONT}.zip"

echo "==> Downloading $FONT Nerd Font..."
TMP=$(mktemp -d)
curl -fLo "$TMP/${FONT}.zip" "$URL"

echo "==> Installing font files..."
unzip -o "$TMP/${FONT}.zip" -d "$FONT_DIR/${FONT}" '*.ttf' 2>/dev/null || \
unzip -o "$TMP/${FONT}.zip" -d "$FONT_DIR/${FONT}" '*.otf' 2>/dev/null

echo "==> Refreshing font cache..."
fc-cache -fv "$FONT_DIR" > /dev/null
rm -rf "$TMP"

echo "✓ Font files installed"

# ── Terminal auto-detection ───────────────────────────────
detect_terminal() {
  local pid=$$
  while [ "$pid" != "1" ] && [ -n "$pid" ]; do
    pid=$(ps -p "$pid" -o ppid= 2>/dev/null | tr -d ' ')
    local name
    name=$(ps -p "$pid" -o comm= 2>/dev/null | tr -d ' ')
    case "$name" in
      konsole)          echo "konsole";   return ;;
      gnome-terminal*)  echo "gnome";     return ;;
      gnome-terminal-*) echo "gnome";     return ;;
      kitty)            echo "kitty";     return ;;
      alacritty)        echo "alacritty"; return ;;
      xfce4-terminal)   echo "xfce";      return ;;
      xterm)            echo "xterm";     return ;;
    esac
  done
  echo "unknown"
}

# ── Terminal-specific font setters ────────────────────────

set_font_konsole() {
  echo "==> Detected terminal: Konsole"
  local profile_dir="$HOME/.local/share/konsole"
  mkdir -p "$profile_dir"

  # Find existing profiles or create default
  local profiles
  profiles=$(find "$profile_dir" -name "*.profile" 2>/dev/null)

  if [ -z "$profiles" ]; then
    # No profile exists, create one and set it as default
    local profile_file="$profile_dir/Default.profile"
    cat > "$profile_file" << EOF
[Appearance]
Font=$FONT_FAMILY,$FONT_SIZE,-1,5,50,0,0,0,0,0

[General]
Name=Default
Parent=FALLBACK/
EOF
    echo "==> Created new Konsole profile: Default.profile"

    # Set as default profile
    local konsole_rc="$HOME/.config/konsolerc"
    if [ -f "$konsole_rc" ]; then
      if grep -q "DefaultProfile" "$konsole_rc"; then
        sed -i "s/DefaultProfile=.*/DefaultProfile=Default.profile/" "$konsole_rc"
      else
        echo "DefaultProfile=Default.profile" >> "$konsole_rc"
      fi
    else
      mkdir -p "$HOME/.config"
      echo -e "[Desktop Entry]\nDefaultProfile=Default.profile" > "$konsole_rc"
    fi
  else
    # Update all existing profiles
    for profile in $profiles; do
      if grep -q "^\[Appearance\]" "$profile"; then
        if grep -q "^Font=" "$profile"; then
          sed -i "s/^Font=.*/Font=$FONT_FAMILY,$FONT_SIZE,-1,5,50,0,0,0,0,0/" "$profile"
        else
          sed -i "/^\[Appearance\]/a Font=$FONT_FAMILY,$FONT_SIZE,-1,5,50,0,0,0,0,0" "$profile"
        fi
      else
        echo -e "\n[Appearance]\nFont=$FONT_FAMILY,$FONT_SIZE,-1,5,50,0,0,0,0,0" >> "$profile"
      fi
      echo "==> Updated profile: $(basename "$profile")"
    done
  fi

  echo "✓ Font set in Konsole — restart Konsole to apply"
}

set_font_gnome() {
  echo "==> Detected terminal: GNOME Terminal"
  if ! command -v dconf &>/dev/null; then
    sudo apt install -y dconf-cli
  fi

  local profile
  profile=$(dconf list /org/gnome/terminal/legacy/profiles:/ 2>/dev/null | head -1 | tr -d '/')

  if [ -z "$profile" ]; then
    echo "  No GNOME Terminal profile found — skipping auto-set"
    return
  fi

  local path="/org/gnome/terminal/legacy/profiles:/:$profile"
  dconf write "$path/font" "'$FONT_FAMILY $FONT_SIZE'"
  dconf write "$path/use-system-font" "false"
  echo "✓ Font set in GNOME Terminal — restart to apply"
}

set_font_kitty() {
  echo "==> Detected terminal: Kitty"
  local config="$HOME/.config/kitty/kitty.conf"
  mkdir -p "$(dirname "$config")"

  if [ -f "$config" ]; then
    if grep -q "^font_family" "$config"; then
      sed -i "s/^font_family.*/font_family      $FONT_FAMILY/" "$config"
    else
      echo "font_family      $FONT_FAMILY" >> "$config"
    fi
    if grep -q "^font_size" "$config"; then
      sed -i "s/^font_size.*/font_size        $FONT_SIZE.0/" "$config"
    else
      echo "font_size        $FONT_SIZE.0" >> "$config"
    fi
  else
    cat > "$config" << EOF
font_family      $FONT_FAMILY
font_size        $FONT_SIZE.0
EOF
  fi
  echo "✓ Font set in Kitty — reload with Ctrl+Shift+F5"
}

set_font_alacritty() {
  echo "==> Detected terminal: Alacritty"
  local config="$HOME/.config/alacritty/alacritty.yml"
  mkdir -p "$(dirname "$config")"

  if [ -f "$config" ]; then
    if grep -q "family:" "$config"; then
      sed -i "s/family:.*/family: $FONT_FAMILY/" "$config"
    else
      cat >> "$config" << EOF

font:
  normal:
    family: $FONT_FAMILY
  size: $FONT_SIZE
EOF
    fi
  else
    cat > "$config" << EOF
font:
  normal:
    family: $FONT_FAMILY
  size: $FONT_SIZE
EOF
  fi
  echo "✓ Font set in Alacritty — restart to apply"
}

set_font_xfce() {
  echo "==> Detected terminal: Xfce Terminal"
  local config="$HOME/.config/xfce4/terminal/terminalrc"
  mkdir -p "$(dirname "$config")"

  if [ -f "$config" ]; then
    if grep -q "^FontName=" "$config"; then
      sed -i "s/^FontName=.*/FontName=$FONT_FAMILY $FONT_SIZE/" "$config"
    else
      echo "FontName=$FONT_FAMILY $FONT_SIZE" >> "$config"
    fi
  else
    echo -e "[Configuration]\nFontName=$FONT_FAMILY $FONT_SIZE" > "$config"
  fi
  echo "✓ Font set in Xfce Terminal — restart to apply"
}

set_font_unknown() {
  echo ""
  echo "  Could not auto-detect your terminal emulator."
  echo "  Manually set your font to: $FONT_FAMILY"
  echo ""
  echo "  Common locations:"
  echo "    Konsole    → Settings → Edit Current Profile → Appearance → Font"
  echo "    GNOME      → Preferences → Profile → Text → Custom font"
  echo "    Kitty      → ~/.config/kitty/kitty.conf → font_family"
  echo "    Alacritty  → ~/.config/alacritty/alacritty.yml → font.normal.family"
  echo "    Xfce       → Preferences → Appearance → Font"
}

# ── Run the right setter ──────────────────────────────────
echo ""
echo "==> Detecting terminal emulator..."
TERMINAL=$(detect_terminal)

case "$TERMINAL" in
  konsole)   set_font_konsole ;;
  gnome)     set_font_gnome ;;
  kitty)     set_font_kitty ;;
  alacritty) set_font_alacritty ;;
  xfce)      set_font_xfce ;;
  *)         set_font_unknown ;;
esac

echo ""
echo "✓ Done! Font: $FONT_FAMILY $FONT_SIZE"
