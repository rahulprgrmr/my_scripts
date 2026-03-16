#!/bin/bash

# Source paths (inside your dotfiles repo)
DOTFILES_DIR="$HOME/Personal/my_dotfiles"

SOURCE_ZSHRC="$DOTFILES_DIR/.zshrc"
SOURCE_CONFIG_DIR="$DOTFILES_DIR/.config/zshrc"

# Target paths
TARGET_ZSHRC="$HOME/.zshrc"
TARGET_CONFIG_DIR="$HOME/.config/zshrc"

create_symlink() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    echo "❌ Source $source does not exist. Skipping."
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "⚠️ Target $target already exists."

    read -p "Do you want to remove it and continue? (y/n): " choice
    case "$choice" in
    y | Y)
      echo "🗑️ Removing $target"
      rm -rf "$target"
      ;;
    *)
      echo "❌ Skipping $target"
      return
      ;;
    esac
  fi

  ln -s "$source" "$target"
  echo "✅ Symlink created: $target -> $source"
}

echo "⚙️ Setting up Zsh configuration..."

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Create symlinks
create_symlink "$SOURCE_ZSHRC" "$TARGET_ZSHRC"
create_symlink "$SOURCE_CONFIG_DIR" "$TARGET_CONFIG_DIR"

echo "🎉 Zsh setup complete."
