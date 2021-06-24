#!/bin/bash
#########################################################
# Created by W7SVT May 2021 #############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################
sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
sudo locale-gen

FILE=$(zenity --file-selection --title="Select a html file" --file-filter="*.html")
if [ -z  "$FILE" ]
then
    exit 1
fi

if zenity --question --title="HTML viewer" --text="Would you like to open this file with Browser?"
then
    xdg-open "file://${FILE}"
else
    zenity --text-info --filename="$FILE" --html --title="HTML viewer"
fi

sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  curl \
  cmake \
  pavucontrol \
  git \
  python3 \
  python3-pip
sudo pip3 install pi-ina219

pcmanfm --set-wallpaper $HOME/baconTelegraph/files/radioRoom2.jpeg 
