#!/usr/bin/env bash

snaps=(
  "chromium"
  "firefox"
  "code --classic"
  "postman"
  "intellij-idea-ultimate --classic" 
)

for snap in "${snaps[@]}"
do
  sudo snap install $snap
done

# sudo apt-get -y install mysql-workbench-community
