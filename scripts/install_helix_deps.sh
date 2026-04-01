#!/bin/bash

# Ubuntu packages
sudo apt install -y \
  clangd

sudo apt-get install -y \
  dotnet-sdk-10.0 \
  dotnet-runtime-10.0

# NPM global installs
npm i -g \
  bash-language-server@5.6.0 \
  dockerfile-language-server-nodejs@0.15.0 \
  prettier@3.8.1 \
  @taplo/cli@0.7.0 \
  tombi@0.9.13 \
  yaml-language-server@1.21.0 \
  @ansible/ansible-language-server@1.2.3 \
  vscode-langservers-extracted@4.10.0

npm list -g

hx --health
