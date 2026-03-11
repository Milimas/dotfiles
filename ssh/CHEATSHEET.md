# ssh — Cheatsheet

> Config lives at `~/.ssh/config`

---

## Generate a Key

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/id_github
```

| Flag | Purpose |
|------|---------|
| `-t ed25519` | Key type (ed25519 is modern and secure) |
| `-C "email"` | Comment to identify the key |
| `-f ~/.ssh/id_github` | Output file path |

---

## Add Key to ssh-agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github
```

---

## Add Key to GitHub

```bash
cat ~/.ssh/id_github.pub
# Copy output → GitHub → Settings → SSH keys → New SSH key
```

---

## Config File Structure

```
Host *                  → global defaults for all connections
Host github.com         → personal GitHub
Host github-work        → work GitHub (separate key)
Host myserver           → VPS or remote machine
Host internal           → machine behind a jump host
```

---

## Multiple GitHub Accounts

```bash
# Clone using work account alias
git clone git@github-work:org/repo.git

# Update remote on existing repo
git remote set-url origin git@github-work:org/repo.git
```

---

## Useful ssh Commands

| Command | Action |
|---------|--------|
| `ssh myserver` | Connect to a host |
| `ssh-copy-id myserver` | Copy your public key to a server |
| `ssh -L 8080:localhost:80 myserver` | Local port forwarding |
| `ssh -T git@github.com` | Test GitHub SSH connection |

---

## File Permissions (required)

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_github
chmod 644 ~/.ssh/id_github.pub
```
