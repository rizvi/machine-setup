#!/usr/bin/env bash

# Pretty print a message.
function log {
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
 echo "$1 already setup"
}
