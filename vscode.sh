#!/usr/bin/env bash
echo "🪛 Installing VSCode Extensions:"
echo "--------------------------------"

# Locate QGIS binary
QGIS_BIN=$(which qgis)

if [[ -z "$QGIS_BIN" ]]; then
    echo "Error: QGIS binary not found!"
    exit 1
fi

# Extract the Nix store path (removing /bin/qgis)
QGIS_PREFIX=$(dirname "$(dirname "$QGIS_BIN")")

# Construct the correct QGIS Python path
QGIS_PYTHON_PATH="$QGIS_PREFIX/share/qgis/python"
# Needed for qgis processing module import
PROCESSING_PATH="$QGIS_PREFIX/share/qgis/python/qgis"

# Check if the Python directory exists
if [[ ! -d "$QGIS_PYTHON_PATH" ]]; then
    echo "Error: QGIS Python path not found at $QGIS_PYTHON_PATH"
    exit 1
fi

# Create .env file for VSCode
ENV_FILE=".env"

QTPOSITIONING="/nix/store/nb3gkbi161fna9fxh9g3bdgzxzpq34gf-python3.11-pyqt5-5.15.10/lib/python3.11/site-packages"

echo "Creating VSCode .env file..."
cat <<EOF > "$ENV_FILE"
PYTHONPATH=$QGIS_PYTHON_PATH:$QTPOSITIONING
QGIS_PREFIX_PATH=$QGIS_PREFIX
PYQT5_PATH="$QGIS_PREFIX/share/qgis/python/PyQt"
QT_QPA_PLATFORM=offscreen
EOF

echo "✅ .env file created successfully!"
echo "Contents of .env:"
cat "$ENV_FILE"

# Also set the python path in this shell in case we want to run tests etc from the command line
export PYTHONPATH=$PYTHONPATH:$QGIS_PYTHON_PATH

# Ensure .vscode directory exists
mkdir -p .vscode

# Define the settings.json file path
SETTINGS_FILE=".vscode/settings.json"

# Ensure settings.json exists
if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "{}" > "$SETTINGS_FILE"
fi

# Update settings.json non-destructively
echo "Updating VSCode settings.json..."
jq --arg pyenv "\${workspaceFolder}/.env" \
   --arg qgispath "$QGIS_PYTHON_PATH" \
   --arg prefixpath "$QGIS_PREFIX" \
   '.["python.envFile"] = $pyenv |
    .["python.analysis.extraPaths"] += [$qgispath] |
    .["terminal.integrated.env.linux"].PYTHONPATH = $qgispath |
    .["git.enableCommitSigning"] = true' \
   "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo "✅ VSCode settings.json updated successfully!"
echo "Contents of settings.json:"
cat "$SETTINGS_FILE"

# Install required extensions
code --user-data-dir='.vscode' \
--profile='nix-config' \
--extensions-dir='.vscode-extensions' . \
--install-extension bbenoist.nix@1.0.1 \
--install-extension bierner.markdown-mermaid@1.27.0 \
--install-extension formulahendry.code-runner@0.12.2 \
--install-extension foxundermoon.shell-format@7.2.5 \
--install-extension github.copilot@1.250.0 \
--install-extension github.copilot-chat@0.22.4 \
--install-extension jeff-hykin.better-shellscript-syntax@1.10.0 \
--install-extension joffreykern.markdown-toc@1.4.0 \
--install-extension kamadorueda.alejandra@1.0.0 \
--install-extension mads-hartmann.bash-ide-vscode@1.43.0 \
--install-extension marp-team.marp-vscode@3.1.0 \
--install-extension mkhl.direnv@0.17.0 \
--install-extension naumovs.color-highlight@2.8.0 \
--install-extension pinage404.bash-extension-pack@2.0.0 \
--install-extension rogalmic.bash-debug@0.3.9 \
--install-extension rpinski.shebang-snippets@1.1.0 \
--install-extension shd101wyy.markdown-preview-enhanced@0.8.15 \
--install-extension spmeesseman.vscode-taskexplorer@2.13.2 \
--install-extension timonwong.shellcheck@0.37.7 \
--install-extension waderyan.gitblame@11.1.2


# Launch VSCode with the sandboxed environment
code --user-data-dir='.vscode' \
--profile='nix-config' \
--extensions-dir='.vscode-extensions' .
