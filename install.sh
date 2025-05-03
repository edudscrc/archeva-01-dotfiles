#!/bin/bash

DOTFILES_DIR=~/archeva-01-dotfiles
CONFIG_DIR=~/.config

declare -A DOTFILES
DOTFILES=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["kitty"]="$CONFIG_DIR/kitty"
    ["fastfetch"]="$CONFIG_DIR/fastfetch"
    ["dunst"]="$CONFIG_DIR/dunst"
)

declare -A HOME_FILES
HOME_FILES=(
    [".bashrc"]="$HOME/.bashrc"
    ["freshix.theme"]="$HOME/.config/btop/themes/freshix.theme"
)

echo "Setting up dotfiles..."

for folder in "${!DOTFILES[@]}"; do
    TARGET="${DOTFILES[$folder]}"
    SOURCE="$DOTFILES_DIR/$folder"

    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

for file in "${!HOME_FILES[@]}"; do
    TARGET="${HOME_FILES[$file]}"
    SOURCE="$DOTFILES_DIR/$file"

    if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "Backing up existing $TARGET to $TARGET.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    cp "$SOURCE" "$TARGET"
    echo "Copied $SOURCE -> $TARGET"
done

hyprctl reload

echo "Dotfiles setup complete!"
