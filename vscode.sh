#!/bin/bash

# ---------------------------------------------------
# Install extensions
# ---------------------------------------------------
code --install-extension vscodevim.vim 
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-extension dbaeumer.vscode-eslint
code --install-extension equinusocio.vsc-material-theme
code --install-extension pkief.material-icon-theme 
code --install-extension esbenp.prettier-vscode
# ---------------------------------------------------

# Copy settings
# ---------------------------------------------------
VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
if [[ -e $VSCODE_CONFIG_DIR/keybindings.json ]]; then
  skip "$VSCODE_CONFIG_DIR/keybindings.json"
else
  log "Setting up VSCode keybindings"
  sudo ln -s $DOTFILES_DIR/vscode/keybindings.json $VSCODE_CONFIG_DIR/keybindings.json
fi

if [[ -e $VSCODE_CONFIG_DIR/settings.json ]]; then
  skip "$VSCODE_CONFIG_DIR/settings.json"
else
  log "Setting up VSCode settings.json"
  sudo ln -s $DOTFILES_DIR/vscode/settings.json $VSCODE_CONFIG_DIR/settings.json
fi

if [[ -d $VSCODE_CONFIG_DIR/snippets ]]; then
  skip "$VSCODE_CONFIG_DIR/snippets"
else
  log "Setting up VSCode snippets"
  sudo ln -s $DOTFILES_DIR/vscode/snippets $VSCODE_CONFIG_DIR/snippets
fi
# ---------------------------------------------------