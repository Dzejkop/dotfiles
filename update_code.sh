#!/usr/bin/env bash

code --list-extensions | sort > vscode/extensions

cp ~/.config/Code/User/settings.json vscode/settings.json
cp ~/.config/Code/User/keybindings.json vscode/keybindings.json
cp ~/.config/Code/User/snippets/rust.json vscode/snippets/rust.json