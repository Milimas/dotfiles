#!/bin/bash
# ============================================================
#  mkproject — create a new C++ CMake project
#  Usage: mkproject <project-name>
# ============================================================

set -e

if [ -z "$1" ]; then
  echo "Usage: mkproject <project-name>"
  exit 1
fi

NAME=$1

mkdir -p "$NAME"/{src,include/"$NAME",tests,cmake}
cd "$NAME"

# Root CMakeLists.txt
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.16)
project($NAME)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(OpenGL_GL_PREFERENCE GLVND)

list(APPEND CMAKE_MODULE_PATH \${CMAKE_SOURCE_DIR}/cmake)

add_subdirectory(src)
add_subdirectory(tests)
EOF

# src CMakeLists.txt
cat > src/CMakeLists.txt << EOF
add_executable($NAME main.cpp)

target_include_directories($NAME PRIVATE
    \${CMAKE_SOURCE_DIR}/include
)
EOF

# tests CMakeLists.txt
cat > tests/CMakeLists.txt << EOF
enable_testing()
EOF

# main.cpp
cat > src/main.cpp << EOF
#include <cstdint>
#include <iostream>

int main() {
    std::cout << "Hello from $NAME!" << std::endl;
    return 0;
}
EOF

# .clangd
cat > .clangd << EOF
CompileFlags:
  CompilationDatabase: build/
EOF

# .gitignore
cat > .gitignore << EOF
build/
.cache/
*.o
*.a
EOF

# Build
mkdir -p build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 > /dev/null
cd ..
ln -sf build/compile_commands.json compile_commands.json

# Init git
git init > /dev/null
git add . > /dev/null
git commit -m "init: $NAME project" > /dev/null

echo ""
echo "✓ Project '$NAME' created!"
echo ""
echo "  cd $NAME"
echo "  cmake --build build"
echo "  ./build/src/$NAME"
