# cmake — Cheatsheet

---

## mkproject

Scaffold a new C++ project from anywhere:

```bash
mkproject myproject
cd myproject
cmake --build build
./build/src/myproject
```

### Generated structure

```
myproject/
├── src/
│   └── main.cpp
├── include/
│   └── myproject/
├── tests/
├── cmake/
├── build/                     ← auto-generated
├── compile_commands.json      ← symlinked for clangd
├── CMakeLists.txt
├── .clangd
└── .gitignore
```

> Also initializes a git repo with an initial commit.

---

## Build Commands

| Command | Action |
|---------|--------|
| `cmake -B build` | Configure project |
| `cmake --build build` | Build project |
| `cmake --build build --clean-first` | Clean then build |
| `./build/src/myproject` | Run executable |

---

## Useful Flags

| Flag | Purpose |
|------|---------|
| `-DCMAKE_EXPORT_COMPILE_COMMANDS=1` | Generate `compile_commands.json` for clangd |
| `-DCMAKE_BUILD_TYPE=Debug` | Debug build with symbols |
| `-DCMAKE_BUILD_TYPE=Release` | Optimized release build |
| `-B build` | Output build files to `build/` folder |

---

## Per-project clangd Setup

```bash
# After cmake runs, symlink compile_commands.json to project root
ln -s build/compile_commands.json compile_commands.json
```

clangd reads this file to understand your project's include paths and flags, which eliminates false errors in Vim.
