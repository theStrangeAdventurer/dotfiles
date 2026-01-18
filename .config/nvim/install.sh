#!/bin/sh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "${GREEN}Installing LSP servers...${NC}"

OS="$(uname -s)"

# Installing clangd
if [ "$OS" = "Darwin" ]; then
  echo "${GREEN}Detected macOS${NC}"
  if ! command_exists brew; then
    echo "${RED}Error: Homebrew required. Install from https://brew.sh/${NC}"
    exit 1
  fi
  brew install llvm

elif [ "$OS" = "Linux" ]; then
  if grep -q "^ID=arch" /etc/os-release || [ -f /etc/arch-release ]; then
    echo "${GREEN}Detected Arch Linux${NC}"
    sudo pacman -Syu --noconfirm --needed clang
  elif command -v apt >/dev/null 2>&1; then
    echo "${GREEN}Detected Debian/Ubuntu${NC}"
    sudo apt update
    sudo apt install -y clangd
  else
    echo "${RED}Unsupported Linux distro. Install clangd manually: https://clangd.llvm.org/installation${NC}"
    exit 1
  fi
else
  echo "${RED}Error: Unsupported OS: $OS${NC}"
  exit 1
fi

if [ "$OS" = "Darwin" ]; then
  echo "${GREEN}Detected macOS${NC}"
  brew install lua-language-server

elif [ "$OS" = "Linux" ]; then
	if grep -q "^ID=arch" /etc/os-release || [ -f /etc/arch-release ]; then
    echo "${GREEN}Detected Arch Linux — using official package${NC}"
    sudo pacman -Syu --noconfirm --needed lua-language-server
  elif command -v apt >/dev/null 2>&1; then
    echo "${YELLOW}Installing lua-language-server from source (no apt package)${NC}"
    INSTALL_DIR="$HOME/.lua-ls"
    mkdir -p "$INSTALL_DIR"
    cd "$INSTALL_DIR"

    echo "${YELLOW}Downloading latest release...${NC}"
    LATEST_URL=$(curl -s https://api.github.com/repos/LuaLS/lua-language-server/releases/latest \
      | grep "browser_download_url.*linux-x64.tar.gz" | cut -d '"' -f 4)
    curl -L "$LATEST_URL" | tar xz

    sudo ln -sf "$INSTALL_DIR/bin/lua-language-server" /usr/local/bin/lua-language-server
    echo "${GREEN}lua-language-server installed from source${NC}"
  else
    echo "${RED}Unsupported distro for auto-install${NC}"
    exit 1
  fi
else
  echo "${RED}Error: Unsupported OS: $OS${NC}"
  exit 1
fi

if command_exists lua-language-server; then
  echo "${GREEN}Success!: $(which lua-language-server)${NC}"
else
  echo "${RED}Error: Installation failed${NC}"
  exit 1
fi

npm i -g typescript-language-server
# https://github.com/hrsh7th/vscode-langservers-extracted
npm i -g vscode-langservers-extracted
npm i -g vscode-json-languageserver
npm i -g bash-language-server

echo "${GREEN}Installation complete${NC}"

