#!/bin/bash
set -euo pipefail

source .env

# Symlink individual dotfiles to $HOME
for file in ".aliases" ".env"; do
    if [ -f "$file" ]; then
	    ln -sf "$(pwd)/$file" "$HOME/$file"
        grep -qxF "source \$HOME/$file" "$HOME/.bashrc" || echo "source \$HOME/$file" >> "$HOME/.bashrc"
    fi
done

# Symlink config directories
mkdir -p "$XDG_CONFIG_HOME"
for dir in "nvim" "tmux"; do
    if [ -d "$dir" ]; then
	ln -sf "$(pwd)/$dir" "$XDG_CONFIG_HOME"
    fi
done

