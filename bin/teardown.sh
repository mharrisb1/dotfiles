#!/bin/bash
set -euo pipefail

source .env

# Remove symlinks
rm -rf $HOME/.aliases $HOME/.env $XDG_CONFIG_HOME

# Remove modifications to .bashrc
sed -i '/^source \$HOME\/\.aliases$/d; /^source \$HOME\/\.env$/d' ~/.bashrc

