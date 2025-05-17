#!/bin/bash

# Paths
SOURCE_FILE="$HOME/my_dotfiles/.tmux.conf"
TARGET_FILE="$HOME/.tmux.conf"

SOURCE_DIR="$HOME/my_dotfiles/.config/tmux"
TARGET_DIR="$HOME/.config/tmux"

# Handle .tmux.conf
if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Source file $SOURCE_FILE does not exist."
else
    if [ -e "$TARGET_FILE" ]; then
        echo "⚠️ Target file $TARGET_FILE already exists."
        read -p "Do you want to remove it and link again? (y/n): " choice
        case "$choice" in
            y|Y ) rm -f "$TARGET_FILE" ;;
            * ) echo "❌ Skipping .tmux.conf"; TARGET_FILE="" ;;
        esac
    fi

    if [ -n "$TARGET_FILE" ]; then
        ln -s "$SOURCE_FILE" "$TARGET_FILE"
        echo "✅ Symlink created: $TARGET_FILE -> $SOURCE_FILE"
    fi
fi

# Handle ~/.config/tmux directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Source directory $SOURCE_DIR does not exist."
else
    if [ -e "$TARGET_DIR" ]; then
        echo "⚠️ Target directory $TARGET_DIR already exists."
        read -p "Do you want to remove it and link again? (y/n): " choice
        case "$choice" in
            y|Y ) rm -rf "$TARGET_DIR" ;;
            * ) echo "❌ Skipping ~/.config/tmux"; TARGET_DIR="" ;;
        esac
    fi

    if [ -n "$TARGET_DIR" ]; then
        mkdir -p "$HOME/.config"
        ln -s "$SOURCE_DIR" "$TARGET_DIR"
        echo "✅ Symlink created: $TARGET_DIR -> $SOURCE_DIR"
    fi
fi
