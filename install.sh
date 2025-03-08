#!/bin/bash

DOTFILES_DIR=~/archeva-01-dotfiles
CONFIG_DIR=~/.config

declare -A DOTFILES
DOTFILES=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["wlogout"]="$CONFIG_DIR/wlogout"
    ["code-flags.conf"]="$CONFIG_DIR/code-flags.conf"
    ["chrome-flags.conf"]="$CONFIG_DIR/chrome-flags.conf"
)

declare -A HOME_FILES
HOME_FILES=(
    [".bashrc"]="$HOME/.bashrc"
    [".bash_profile"]="$HOME/.bash_profile"
)

echo "Setting up dotfiles..."

# Symlink .config files
for folder in "${!DOTFILES[@]}"; do
    TARGET="${DOTFILES[$folder]}"
    SOURCE="$DOTFILES_DIR/$folder"

    if [ -d "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "Backing up existing $TARGET to $TARGET.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

# Symlink home dotfiles
for file in "${!HOME_FILES[@]}"; do
    TARGET="${HOME_FILES[$file]}"
    SOURCE="$DOTFILES_DIR/$file"

    if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "Backing up existing $TARGET to $TARGET.bak"
        mv "$TARGET" "$TARGET.bak"
    fi

    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

hyprctl reload

echo "Dotfiles setup complete!"
