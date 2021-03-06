#!/usr/bin/env bash

snaps=(
  "chromium"
  "code --classic"
  "firefox"
  "hub --classic"
  "phpstorm --classic"
  "postman"
  "rubymine --classic"
  "vlc"
  "youtube-dl"
)

for snap in "${snaps[@]}"
do
  sudo snap install $snap
done

# sudo apt-get -y install mysql-workbench-community
