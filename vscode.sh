#!/usr/bin/env bash
echo "🪛 Installing VSCode Extensions:"
echo "--------------------------------"

code --extensions-dir=.vscode-extensions --install-extension bbenoist.nix
code --extensions-dir=.vscode-extensions --install-extension kamadorueda.alejandra
code --extensions-dir=".vscode-extensions" .
