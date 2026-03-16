#!/bin/bash

# Paths
SOURCE_FILE="$HOME/Personal/my_dotfiles/.config/starship.toml"
TARGET_FILE="$HOME/.config/starship.toml"

# Check if source exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "❌ Source file $SOURCE_FILE does not exist."
  exit 1
fi

# Check if target already exists
if [ -e "$TARGET_FILE" ] || [ -L "$TARGET_FILE" ]; then
  echo "⚠️ Target $TARGET_FILE already exists."

  read -p "Do you want to remove it and continue? (y/n): " choice
  case "$choice" in
  y | Y)
    echo "🗑️ Removing $TARGET_FILE"
    rm -rf "$TARGET_FILE"
    ;;
  *)
    echo "❌ Aborting. Please remove the target manually if needed."
    exit 1
    ;;
  esac
fi

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Create symlink
ln -s "$SOURCE_FILE" "$TARGET_FILE"

echo "✅ Symlink created: $TARGET_FILE -> $SOURCE_FILE"
