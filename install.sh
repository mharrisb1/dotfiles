#!/bin/bash
set -e

echo "=> Updating apt and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ansible git

DOTFILES_DIR="$HOME/dotfiles"

echo "=> Cloning dotfiles repository..."
if [ -d "$DOTFILES_DIR" ]; then
    echo "=> $DOTFILES_DIR already exists, pulling latest changes..."
    cd "$DOTFILES_DIR"
    git pull
else
    git clone https://github.com/mharrisb1/dotfiles "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
fi

echo "=> Running setup playbook..."
ansible-playbook setup/main.yml

echo "=> Setup complete!"
