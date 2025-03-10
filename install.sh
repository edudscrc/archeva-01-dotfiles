#!/bin/bash

DOTFILES_DIR=~/archeva-01-dotfiles
CONFIG_DIR=~/.config
CACHE_DIR=~/.cache
SPICETIFY_THEMES_DIR=~/.config/spicetify/Themes

declare -A DOTFILES
DOTFILES=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["wlogout"]="$CONFIG_DIR/wlogout"
    ["wal"]="$CACHE_DIR/wal"
    ["kitty"]="$CONFIG_DIR/kitty"
)

declare -A SPICETIFY_THEMES
SPICETIFY_THEMES=(
    ["archeva_01_spicetify"]="$SPICETIFY_THEMES_DIR/archeva_01_spicetify"
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

# Symlink .config files
for folder in "${!SPICETIFY_THEMES[@]}"; do
    TARGET="${SPICETIFY_THEMES[$folder]}"
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

spicetify backup apply
spicetify config current_theme archeva_01_spicetify
spicetify config color_scheme archeva_01_spicetify
spicetify apply

hyprctl reload

echo "Dotfiles setup complete!"
