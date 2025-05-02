#!/usr/bin/env bash
echo "🪛 Installing VSCode Extensions:"
echo "--------------------------------"


# Ensure .vscode directory exists
mkdir -p .vscode
mkdir -p .vscode-extensions
# Define the settings.json file path
SETTINGS_FILE=".vscode/settings.json"

# Ensure settings.json exists
if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "{}" > "$SETTINGS_FILE"
fi

# Update settings.json non-destructively
echo "Updating VSCode settings.json..."
jq '.["git.enableCommitSigning"] = true' \
   "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo "✅ VSCode settings.json updated successfully!"
echo "Contents of settings.json:"
cat "$SETTINGS_FILE"

# Install required extensions
code --user-data-dir='.vscode' \
--profile='nix-config' \
--extensions-dir='.vscode-extensions' . \
--install-extension mkhl.direnv@0.17.0 \
--install-extension kamadorueda.alejandra@1.0.0 \
--install-extension marp-team.marp-vscode@3.1.0 \
--install-extension shd101wyy.markdown-preview-enhanced@0.8.15 \
--install-extension rpinski.shebang-snippets@1.1.0 \
--install-extension joffreykern.markdown-toc@1.4.0 \
--install-extension pinage404.bash-extension-pack@2.0.0 \
--install-extension spmeesseman.vscode-taskexplorer@2.13.2 \
--install-extension pinage404.nix-extension-pack@3.0.0 \
--install-extension mads-hartmann.bash-ide-vscode@1.43.0 \
--install-extension foxundermoon.shell-format@7.2.5 \
--install-extension jeff-hykin.better-shellscript-syntax@1.10.0 \
--install-extension arrterian.nix-env-selector@1.0.12 \
--install-extension timonwong.shellcheck@0.37.7 \
--install-extension jnoortheen.nix-ide@0.4.16 \
--install-extension bierner.markdown-mermaid@1.27.0 \
--install-extension bbenoist.Nix@1.0.1 \
--install-extension GitHub.copilot@1.250.0 \
--install-extension rogalmic.bash-debug@0.3.9 \
--install-extension formulahendry.code-runner@0.12.2 \
--install-extension waderyan.gitblame@11.1.2 \
--install-extension GitHub.copilot-chat@0.25.1 \
--install-extension naumovs.color-highlight@2.8.0

# Launch VSCode with the sandboxed environment
code --user-data-dir='.vscode' \
--profile='nix-config' \
--extensions-dir='.vscode-extensions' .
