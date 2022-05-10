#!/bin/bash
#########################################################
# Created by W7SVT APR 2022  ############################
# Updated by W7SVT APR 2022  ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################
source ~/.bashrc

echo "***************************************************"
echo "# Read/Set CALLSIGN                               #"
echo "***************************************************"
sleep 1

[[ x"${CALLSIGN}" == "x" ]] \
&& CALLSIGN=$(whiptail --title "Set CALLSIGN" \
--inputbox "Please enter your CALLSIGN" 10 30 NOCALL 3>&1 1>&2 2>&3) \
&& export CALLSIGN \
&& sudo echo "export CALLSIGN=$CALLSIGN" >> $HOME/.bashrc \
&& source ~/.bashrc \
|| echo "Your CALLSIGN is set to '$CALLSIGN'"

echo "***************************************************"
echo "# Read/Set GRID                                   #"
echo "***************************************************"
sleep 1

[[ x"${GRID}" == "x" ]] \
&& GRID=$(whiptail --title "Set GRID" \
--inputbox "Please enter your GRID" 10 30 DM41 3>&1 1>&2 2>&3) \
&& export GRID \
&& sudo echo "export GRID=$GRID" >> $HOME/.bashrc \
&& source ~/.bashrc \
|| echo "Your GRID is set to '$GRID'"



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
    False "WSJT-X From SRC" \
    False "JS8call From SRC" \
    False "CHIRP" \
    False "Conky" \
    False "Conky Small Screen" \

    )
echo $ask

case $ask in
   "Prerequisites only") \
     sudo apt update && sudo apt upgrade -y
     sudo apt install -y \
        curl \
        cmake \
        git \
        python3 \
        python3-pip \
        libasound2-dev \
        build-essential \
        gfortran \
        gcc \
        g++ \
        stow \
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
   "JS8call From SRC") \
/bin/sh $HOME/baconTelegraph/js8call_src.sh
;;
   *) \
echo "Sorry, no selection made"
exit 0   
   ;;
esac
####Once More
/bin/sh install.sh
