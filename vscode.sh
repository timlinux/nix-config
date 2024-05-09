#!/usr/bin/env bash
echo "🪛 Installing VSCode Extensions:"
echo "--------------------------------"

code --extensions-dir=.vscode-extensions --install-extension bbenoist.nix
code --extensions-dir=.vscode-extensions --install-extension formulahendry.code-runner
code --extensions-dir=.vscode-extensions --install-extension foxundermoon.shell-format
code --extensions-dir=.vscode-extensions --install-extension github.copilot
code --extensions-dir=.vscode-extensions --install-extension github.copilot-chat
code --extensions-dir=.vscode-extensions --install-extension jeff-hykin.better-shellscript-syntax
code --extensions-dir=.vscode-extensions --install-extension joffreykern.markdown-toc
code --extensions-dir=.vscode-extensions --install-extension kamadorueda.alejandra
code --extensions-dir=.vscode-extensions --install-extension mads-hartmann.bash-ide-vscode
code --extensions-dir=.vscode-extensions --install-extension mkhl.direnv
code --extensions-dir=.vscode-extensions --install-extension naumovs.color-highlight
code --extensions-dir=.vscode-extensions --install-extension pinage404.bash-extension-pack
code --extensions-dir=.vscode-extensions --install-extension rogalmic.bash-debug
code --extensions-dir=.vscode-extensions --install-extension rpinski.shebang-snippets
code --extensions-dir=.vscode-extensions --install-extension spmeesseman.vscode-taskexplorer
code --extensions-dir=.vscode-extensions --install-extension timonwong.shellcheck
code --extensions-dir=.vscode-extensions --install-extension waderyan.gitblame

code --extensions-dir=".vscode-extensions" .
