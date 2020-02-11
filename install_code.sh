#!/usr/bin/env bash

cat vscode/extensions | xargs -L 1 code --install-extension

cp vscode/settings.json ~/.config/Code/User/settings.json
cp vscode/keybindings.json ~/.config/Code/User/keybindings.json
cp vscode/snippets/rust.json ~/.config/Code/User/snippets/rust.json