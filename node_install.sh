#!/bin/bash
# ============================================================
#  node install script
#  Installs fnm or nvm + Node LTS + playground setup
# ============================================================

set -e

echo "==> Installing Node.js environment..."

MANAGER="${NODE_MANAGER:-}"
if [ -z "$MANAGER" ]; then
  echo ""
  echo "Node version manager?"
  echo "  1) fnm (faster, rust-based)"
  echo "  2) nvm"
  read -rp "  Choice [1]: " choice
  case $choice in
    2) MANAGER="nvm" ;;
    *) MANAGER="fnm" ;;
  esac
fi

if [ "$MANAGER" = "fnm" ]; then
  echo "==> Installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash 2>&1 | grep -v "rehash"

  # Load fnm directly from its install path (works without sourcing zshrc)
  FNM_BIN="$HOME/.local/share/fnm"
  export PATH="$FNM_BIN:$PATH"
  eval "$("$FNM_BIN/fnm" env)"

  # Add to zshrc if not already there
  if ! grep -q "fnm env" ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc << 'EOF'

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
EOF
    echo "==> Added fnm to ~/.zshrc"
  fi

  echo "==> Installing Node LTS..."
  "$FNM_BIN/fnm" install --lts
  "$FNM_BIN/fnm" use lts-latest
  "$FNM_BIN/fnm" default lts-latest

else
  echo "==> Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  echo "==> Installing Node LTS..."
  nvm install --lts
  nvm use --lts
  nvm alias default node
fi

# Install global tools
echo "==> Installing global packages..."
npm install -g typescript ts-node nodemon

# Create playground
PLAYGROUND="$HOME/node-playground"
if [ ! -d "$PLAYGROUND" ]; then
  echo "==> Setting up Node playground at ~/node-playground..."
  mkdir -p "$PLAYGROUND"
  cd "$PLAYGROUND"
  npm init -y > /dev/null

  cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"]
}
EOF

  mkdir -p src
  cat > src/index.ts << 'EOF'
// Node.js TypeScript playground
const greet = (name: string): string => {
  return `Hello, ${name}!`;
};

console.log(greet("world"));
EOF

  cat > src/index.js << 'EOF'
// Node.js JavaScript playground
const greet = (name) => `Hello, ${name}!`;
console.log(greet("world"));
EOF

  node -e "
    const pkg = require('./package.json');
    pkg.scripts = {
      'start': 'node src/index.js',
      'ts': 'ts-node src/index.ts',
      'watch': 'nodemon src/index.js',
      'watch:ts': 'nodemon --exec ts-node src/index.ts'
    };
    require('fs').writeFileSync('./package.json', JSON.stringify(pkg, null, 2));
  "
fi

echo ""
echo "✓ Node installed with $MANAGER!"
echo ""
echo "  Run this to activate fnm in your current shell:"
echo "    source ~/.zshrc"
echo ""
echo "  Playground: ~/node-playground"
echo "    npm start         → run JS"
echo "    npm run ts        → run TS"
echo "    npm run watch     → watch JS"
echo "    npm run watch:ts  → watch TS"
