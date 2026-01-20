#!/usr/bin/env bash
set -euo pipefail

URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"
ZIP_NAME="CascadiaCode.zip"

detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)  echo "linux" ;;
    *)      echo "unknown" ;;
  esac
}

pick_font_dir() {
  local os="$1"

  if [[ "$os" == "macos" ]]; then
    # macOS: Alacritty/система берут шрифты отсюда (CoreText)
    echo "$HOME/Library/Fonts"
    return
  fi

  if [[ "$os" == "linux" ]]; then
    # Linux: стандартный пользовательский каталог для fontconfig
    echo "$HOME/.local/share/fonts"
    return
  fi

  echo ""
}

OS="$(detect_os)"
FONT_DIR="$(pick_font_dir "$OS")"

if [[ -z "$FONT_DIR" ]]; then
  echo "Unsupported OS: $(uname -s)"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "OS: $OS"
echo "Installing fonts into: $FONT_DIR"
mkdir -p "$FONT_DIR"

echo "Downloading CascadiaCode Nerd Fonts..."
curl -L -o "$TMP_DIR/$ZIP_NAME" "$URL"

echo "Extracting..."
unzip -o "$TMP_DIR/$ZIP_NAME" -d "$TMP_DIR/extracted" >/dev/null

echo "Copying .ttf/.otf..."
find "$TMP_DIR/extracted" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec cp -f {} "$FONT_DIR/" \;

if [[ "$OS" == "linux" ]]; then
  echo "Updating font cache..."
  fc-cache -f -v >/dev/null
else
  echo "macOS detected: font cache is handled by the system."
  echo "If the font doesn't appear immediately, restart Alacritty (quit полностью) or log out/in."
fi

echo "Done."
