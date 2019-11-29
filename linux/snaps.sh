#!/usr/bin/env bash

snaps=(
  "chromium"
  "code --classic"
  "firefox"
  "intellij-idea-ultimate --classic"
  "postman"
  "youtube-dl"
)

for snap in "${snaps[@]}"
do
  sudo snap install $snap
done

# sudo apt-get -y install mysql-workbench-community
