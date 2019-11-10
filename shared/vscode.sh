#!/usr/bin/env bash

# --------------------------------------------------
# Load dependencies
# --------------------------------------------------
cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
source $cwd/config/variables.sh
source $cwd/lib/utils.sh

# ---------------------------------------------------
# Variables
# ---------------------------------------------------
if [[ `uname` == 'Linux' ]]; then
  vscode_config_dir="$HOME/.config/Code/User"
else
  vscode_config_dir="$HOME/Library/Application Support/Code/User"
fi

# ---------------------------------------------------
# Copy settings
# ---------------------------------------------------
if [[ -e "$vscode_config_dir/keybindings.json" ]]; then
  skip "$vscode_config_dir/keybindings.json"
else
  log "Setting up VSCode keybindings"
  ln -s "$DOTFILES_DIR/vscode/keybindings.json" "$vscode_config_dir/keybindings.json"
fi

if [[ -e "$vscode_config_dir/settings.json" ]]; then
  skip "$vscode_config_dir/settings.json"
else
  log "Setting up VSCode settings.json"
  ln -s "$DOTFILES_DIR/vscode/settings.json" "$vscode_config_dir/settings.json"
fi

if [[ -d "$vscode_config_dir/snippets" ]]; then
  skip "$vscode_config_dir/snippets"
else
  log "Setting up VSCode snippets"
  ln -s "$DOTFILES_DIR/vscode/snippets" "$vscode_config_dir/snippets"
fi