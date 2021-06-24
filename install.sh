#!/bin/bash
#########################################################
# Created by W7SVT May 2021  ############################
# Updated by W7SVT June 2021 ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

ask=$(zenity --title "baconTelegraph Install" \
	--text "Estimate Speed" \
	--list \
	--radiolist \
	--width=400 \
	--height=400 \
	--multiple \
	--column "Install" --column "Tool" \
    False "Prerequisites only" \
    False "hamlib" \
    False "JTDX" \
    False "WSJT-X" \
    False "CHIRP" \
    False "Conky" \
    False "JS8call" \
    )
echo $ask

case $ask in
   "Prerequisites only") \
     sudo apt update && sudo apt upgrade -y
     sudo apt install -y \
        curl \
        cmake \
        pavucontrol \
        git \
        python3 \
        python3-pip
    sudo pip3 install pi-ina219
    sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
    sudo locale-gen
    
    pcmanfm --set-wallpaper $HOME/baconTelegraph/files/radioRoom2.jpeg 
;;
   "hamlib") \
/bin/sh $HOME/baconTelegraph/hamlib.sh
;;
   "JTDX") \
/bin/sh $HOME/baconTelegraph/jtdx.sh
;;
   "WSJT-X") \
/bin/sh $HOME/baconTelegraph/wsjtx.sh
;;
   "CHIRP") \
/bin/sh $HOME/baconTelegraph/chirp.sh
;;
   "Conky") \
/bin/sh $HOME/baconTelegraph/conky.sh
;;
   "JS8call") \
/bin/sh $HOME/baconTelegraph/js8call.sh
;;
   *) \
echo "Sorry, no selection made"
exit 0   
   ;;
esac
/bin/sh test.sh
