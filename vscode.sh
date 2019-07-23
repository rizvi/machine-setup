#!/bin/bash

# ---------------------------------------------------
# Utility functions
# ---------------------------------------------------
# Pretty print a message.
function log {
  echo -e "\n"
  echo "============================================="
  echo $1
  echo "============================================="
}

# Check if a cmd exists.
function cmd_exists {
  command -v $1 > /dev/null 2>&1
}

# Log a skiping message.
function skip {
 log "$1 already exists. Skipping"
}
# ---------------------------------------------------

# ---------------------------------------------------
# Variables
# ---------------------------------------------------
DOTFILES_DIR="$HOME/.config/dotfiles"
if [[ `uname` == 'Linux' ]]; then
  CONFIG_DIR="$HOME/.config/Code/User"
else
  CONFIG_DIR="$HOME/Library/Application Support/Code/User"
fi

log "$CONFIG_DIR"

# ---------------------------------------------------
# Copy settings
# ---------------------------------------------------
if [[ -e "$CONFIG_DIR/keybindings.json" ]]; then
  skip "$CONFIG_DIR/keybindings.json"
else
  log "Setting up VSCode keybindings"
  ln -s "$DOTFILES_DIR/vscode/keybindings.json" "$CONFIG_DIR/keybindings.json"
fi

if [[ -e "$CONFIG_DIR/settings.json" ]]; then
  skip "$CONFIG_DIR/settings.json"
else
  log "Setting up VSCode settings.json"
  ln -s "$DOTFILES_DIR/vscode/settings.json" "$CONFIG_DIR/settings.json"
fi

if [[ -d "$CONFIG_DIR/snippets" ]]; then
  skip "$CONFIG_DIR/snippets"
else
  log "Setting up VSCode snippets"
  ln -s "$DOTFILES_DIR/vscode/snippets" "$CONFIG_DIR/snippets"
fi
# ---------------------------------------------------


# ---------------------------------------------------
# Install extensions
# ---------------------------------------------------
code --install-extension vscodevim.vim 
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-extension dbaeumer.vscode-eslint
code --install-extension equinusocio.vsc-material-theme
code --install-extension pkief.material-icon-theme 
code --install-extension esbenp.prettier-vscode
code --install-extension jpoissonnier.vscode-styled-components
# ---------------------------------------------------
