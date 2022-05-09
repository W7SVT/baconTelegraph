#!/bin/bash
#########################################################
# Created by W7SVT May 2021  ############################
# Updated by W7SVT Nov 2021  ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

echo "***************************************************"
echo "# Read/Set CALLSIGN                               #"
echo "***************************************************"

if [ -n "$CALLSIGN" ]; then
  echo "Your CALLSIGN is set to '$CALLSIGN'"
  echo "If you whish to change it please run 'sudo mousepad ~/.bashrc' and change it on the last line"
else
  read  -r -p "What is your CALLSIGN?:" CALLSIGN
  sudo echo "export CALLSIGN=$CALLSIGN" >> $HOME/.bashrc
fi

echo "***************************************************"
echo "# Read/Set GRID                                   #"
echo "***************************************************"
sleep 1

if [ -n "$GRID" ]; then
  echo "Your GRID is set to '$GRID'"
  echo "If you whish to change it please run 'sudo mousepad ~/.bashrc' and change it on the last line"
else
  read  -r -p "What is your GRID?:" GRID
  sudo echo "export GRID=$GRID" >> $HOME/.bashrc
fi

sleep 1

echo "***************************************************"
echo "# Zenity Install Menu#"
echo "***************************************************"

ask=$(zenity --title "baconTelegraph Install" \
	--text "Proof that Pi is irrational" \
	--list \
	--radiolist \
	--width=400 \
	--height=400 \
	--multiple \
	--column "Install" --column "Tool" \
    False "Prerequisites only" \
    False "hamlib" \
    False "JTDX From SRC" \
    False "WSJT-X" \
    False "WSJT-X From SRC" \
    False "CHIRP" \
    False "Conky" \
    False "Conky Small Screen" \
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
        python3-pip \
        libasound2-dev \
        extra-xdg-menus 
    sudo pip3 install pi-ina219
    sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
    sudo locale-gen
    sudo raspi-config nonint do_ssh
    pcmanfm --set-wallpaper $HOME/baconTelegraph/files/radioRoom2.jpeg 
;;
   "hamlib") \
/bin/sh $HOME/baconTelegraph/hamlib.sh
;;
   "JTDX From SRC") \
/bin/sh $HOME/baconTelegraph/jtdx_src.sh
;;
   "WSJT-X") \
/bin/sh $HOME/baconTelegraph/wsjtx.sh
;;
   "WSJT-X From SRC") \
/bin/sh $HOME/baconTelegraph/wsjtx_src.sh
;;
   "CHIRP") \
/bin/sh $HOME/baconTelegraph/chirp.sh
;;
   "Conky") \
/bin/sh $HOME/baconTelegraph/conky.sh
;;
   "Conky") \
/bin/sh $HOME/baconTelegraph/conkySM.sh
;;
   "JS8call") \
/bin/sh $HOME/baconTelegraph/js8call.sh
;;
   *) \
echo "Sorry, no selection made"
exit 0   
   ;;
esac
####Once More
/bin/sh install.sh
