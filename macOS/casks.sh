#!/usr/bin/env bash

# --------------------------------------------------
# Load dependencies
# --------------------------------------------------
cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
source $cwd/../shared/config/variables.sh
source $cwd/../shared/lib/utils.sh

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
  "android-file-transfer"
  "balsamiq-mockups"
  "clipy"
  "dash"
  "db-browser-for-sqlite"
  "docker"
  "firefox"
  "github"
  "google-chrome"
  "karabiner-elements"
  "lastpass"
  "libreoffice"
  "livereload"
  "microsoft-word"
  "mysqlworkbench"
  "pgadmin4"
  "postman"
  "pycharm"
  "sourcetree"
  "spectacle"
  "toggl"
  "transmission"
  "visual-studio-code"
  "virtualbox"
)

for cask in "${casks[@]}"
do
  install_cask $cask
done
