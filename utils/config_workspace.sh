#!/usr/bin/env bash
set -e

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs lts
asdf global nodejs lts

npm i -g live-server vscode-langservers-extracted emmet-ls @fsouza/prettierd
