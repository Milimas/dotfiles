# node — Cheatsheet

> Playground lives at `~/node-playground`

---

## Playground Scripts

| Command | Action |
|---------|--------|
| `npm start` | Run `src/index.js` |
| `npm run ts` | Run `src/index.ts` with ts-node |
| `npm run watch` | Watch and re-run JS on save |
| `npm run watch:ts` | Watch and re-run TS on save |

---

## fnm (recommended)

| Command | Action |
|---------|--------|
| `fnm install 20` | Install Node 20 |
| `fnm install --lts` | Install latest LTS |
| `fnm use 20` | Switch to Node 20 |
| `fnm list` | List installed versions |
| `fnm current` | Show active version |
| `fnm default 20` | Set default version |

---

## nvm

| Command | Action |
|---------|--------|
| `nvm install 20` | Install Node 20 |
| `nvm install --lts` | Install latest LTS |
| `nvm use 20` | Switch to Node 20 |
| `nvm ls` | List installed versions |
| `nvm current` | Show active version |
| `nvm alias default 20` | Set default version |

---

## Global Tools Installed

| Tool | Purpose |
|------|---------|
| `typescript` | TypeScript compiler (`tsc`) |
| `ts-node` | Run TypeScript directly without compiling |
| `nodemon` | Auto-restart on file changes |
