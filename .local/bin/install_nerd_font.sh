#!/bin/bash
FONT_DIR="$HOME/.local/share/fonts/CaskaydiaMono"
mkdir -p "$FONT_DIR"

echo "Downloading Caskaydia Mono Nerd Font..."
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip

echo "Extracting..."
unzip -o CascadiaCode.zip -d "$FONT_DIR"

echo "Updating font cache..."
fc-cache -fv

rm CascadiaCode.zip
echo "Done!"
