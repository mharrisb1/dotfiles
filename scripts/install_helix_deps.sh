#!/bin/bash

sudo apt install -y \
  clangd \
  python3-pip \
  pipx

sudo apt-get install -y \
  dotnet-sdk-10.0 \
  dotnet-runtime-10.0

npm i -g \
  bash-language-server@5.6.0 \
  dockerfile-language-server-nodejs@0.15.0 \
  prettier@3.8.1 \
  @taplo/cli@0.7.0 \
  tombi@0.9.13 \
  yaml-language-server@1.21.0 \
  @ansible/ansible-language-server@1.2.3 \
  vscode-langservers-extracted@4.10.0 \
  typescript-language-server@5.1.3 \
  @tailwindcss/language-server@0.14.29 \
  @microsoft/compose-language-service@0.5.0

npm list -g

pipx install ansible-lint==26.4.0
pipx install basedpyright==1.39.0

pipx list

uv tool install ruff@0.15.9

hx --health
