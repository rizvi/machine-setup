#!/usr/bin/env bash

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"

# --------------------------------------------------
# Load dependencies
# --------------------------------------------------
source $cwd/../config/variables.sh
source $cwd/../lib/utils.sh

# --------------------------------------------------
# Check if a cask is already installed
# --------------------------------------------------
function cask_installed {
  brew cask list | grep ^$1$ > /dev/null 2>&1
}

# --------------------------------------------------
# Install a cask
# --------------------------------------------------
function install_cask {
  if cask_installed $1; then
    skip "$1 cask"
  else
    log "Installing $1 cask"
    brew cask install $1
    log "$1 cask successfully installed"
  fi
}

# --------------------------------------------------
# List of casks to install
# --------------------------------------------------
casks=(
  "alfred"
  "clipy"
  "docker"
  "evernote"
  "google-chrome"
  "karabiner-elements"
  "lastpass"
  "mysqlworkbench"
  "postman"
  "sequel-pro"
  "sourcetree"
  "spectacle"
  "visual-studio-code"
  "rubymine"
  "virtualbox"
)

for cask in "${casks[@]}"
do
  install_cask $cask
done
