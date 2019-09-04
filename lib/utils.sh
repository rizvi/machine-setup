#!/usr/bin/env bash

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

# Log a skipping message.
function skip {
 echo "$1 already installed"
}

# Install brew formula
function install_formula {
  if cmd_exists $1; then
    skip $1
  else
    log "Installing $1"
    brew install $1
  fi
}

