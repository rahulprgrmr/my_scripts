#!/bin/bash

# Paths
SOURCE_DIR="$HOME/Personal/my_dotfiles/.config/kitty"
TARGET_DIR="$HOME/.config/kitty"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Source directory $SOURCE_DIR does not exist."
  exit 1
fi

# Check if target already exists
if [ -e "$TARGET_DIR" ]; then
  echo "⚠️ Target directory $TARGET_DIR already exists."

  read -p "Do you want to remove it and continue? (y/n): " choice
  case "$choice" in
  y | Y)
    echo "🗑️ Removing $TARGET_DIR"
    rm -rf "$TARGET_DIR"
    ;;
  *)
    echo "❌ Aborting. Please remove the target manually if needed."
    exit 1
    ;;
  esac
fi

# Create parent .config directory if missing
mkdir -p "$HOME/.config"

# Create symlink
ln -s "$SOURCE_DIR" "$TARGET_DIR"

echo "✅ Symlink created: $TARGET_DIR -> $SOURCE_DIR"
