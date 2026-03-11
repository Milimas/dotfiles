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
  curl -fsSL https://fnm.vercel.app/install | bash
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"

  # Add to zshrc if not already there
  if ! grep -q "fnm env" ~/.zshrc 2>/dev/null; then
    echo '' >> ~/.zshrc
    echo '# fnm' >> ~/.zshrc
    echo 'export PATH="$HOME/.local/share/fnm:$PATH"' >> ~/.zshrc
    echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
  fi

  fnm install --lts
  fnm use lts-latest

else
  echo "==> Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install --lts
  nvm use --lts
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

  # TypeScript config
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

  # Add scripts to package.json
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
echo "  Playground: ~/node-playground"
echo "    npm start       → run JS"
echo "    npm run ts      → run TS"
echo "    npm run watch   → watch JS"
echo "    npm run watch:ts → watch TS"
