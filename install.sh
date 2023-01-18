#!/usr/bin/env bash
#########################################################
# Created by W7SVT APR 2022  ############################
# Updated by W7SVT JAN 2023  ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

#**************************************************
#  Read/Set CALLSIGN                              #
#**************************************************

[[ x"${CALLSIGN}" == "x" ]] \
&& CALLSIGN=$(whiptail --title "Set CALLSIGN" \
--inputbox "Please enter your CALLSIGN" 10 30 NOCALL 3>&1 1>&2 2>&3) \
&& export CALLSIGN \
&& sudo echo "export CALLSIGN=$CALLSIGN" >> $HOME/.bashrc \
&& source ~/.bashrc \
|| sleep 1 

#**************************************************
# Read/Set GRID                                   #
#**************************************************

[[ x"${GRID}" == "x" ]] \
&& GRID=$(whiptail --title "Set GRID" \
--inputbox "Please enter your GRID" 10 30 DM41 3>&1 1>&2 2>&3) \
&& export GRID \
&& sudo echo "export GRID=$GRID" >> $HOME/.bashrc \
&& source ~/.bashrc \
|| sleep 1

# Display if GRID and CALLSIGN are set

TERM=ansi  whiptail --title "Howdy , Welcome to baconTelegraph" --infobox "Your CALL is set to ${CALLSIGN} and are in maidenhead grid ${GRID}" 8 78 
sleep 4

echo "***************************************************"
echo "# whiptail Install Menu#"
echo "***************************************************"


SELECTED=$(whiptail --separate-output --backtitle "Proof that Pi is irrational" \
   --title "SELECT PACKAGES TO INSTALL" --radiolist \
   "${callsign} Welcome to baconTelegraph" 20 100 10 \
   Prerequisites "Install only prerequisites and none of the apps" ON \
   ALL "Install all applications (Prerequisites required first) " OFF \
   hamlib "Rig control for most radios" OFF \
   JTDX "Feature Rich Software for FT8 and Other JT Modes" OFF \
   WSJT-X "FST4(W), FT4, FT8, JT4, JT9, JT65, Q65, MSK144, & WSPR" OFF \
   JS8Call "Digital weak signal keyboard to keyboard messaging" OFF \
   wfview "Open-source software for the control of modern Icom radios" OFF \
   QSSTV "SlowScan Televison or images over radio" OFF \
   ARDOP "HF Radio Modem - Amateur Radio Digital Open Protocol" OFF \
   Direwolf "AX.25 packet modem/TNC and APRS encoder/decoder" OFF \
   XASTIR "X Amateur Station Tracking and Information Reporting (APRS)" OFF \
   CHIRP "Open Source Radio Programmer" OFF \
   Conky "On Screen Display" OFF \
   ConkySM "On Screen Display - Small Screen Version" OFF \
   OP25 "P25 Decoder - Listen to P25" OFF \
   gpsTimeSync "Enable timesync with timeserver and GPS" OFF 3>&1 1>&2 2>&3)

case $SELECTED in
   "Prerequisites") \
     sudo apt update && sudo apt upgrade -y
     sudo apt install -y \
        curl \
        cmake \
        git \
        python3 \
        python3-pip \
        python3-dev \
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

    find /lib/modules -type f -name "*.ko"|grep cp21

    sudo modprobe cp210x


    sudo raspi-config nonint do_ssh
    pcmanfm --set-wallpaper $HOME/baconTelegraph/files/radioRoom2.jpeg 
;;
   "ALL") \
/bin/sh $HOME/baconTelegraph/install_all.sh
;;
   "hamlib") \
/bin/sh $HOME/baconTelegraph/hamlib_src.sh
;;
   "JTDX") \
/bin/sh $HOME/baconTelegraph/jtdx_src.sh
;;
   "WSJT-X") \
/bin/sh $HOME/baconTelegraph/wsjtx_src.sh
;;
   "CHIRP") \
/bin/sh $HOME/baconTelegraph/chirp.sh
;;
   "Conky") \
/bin/sh $HOME/baconTelegraph/conky.sh
;;
   "ConkySM") \
/bin/sh $HOME/baconTelegraph/conkySM.sh
;;
   "JS8Call") \
/bin/sh $HOME/baconTelegraph/js8call_src.sh
;;
   "wfview") \
/bin/sh $HOME/baconTelegraph/wfview_src.sh
;;
   "QSSTV") \
/bin/sh $HOME/baconTelegraph/qsstv_src.sh
;;
   "ARDOP") \
/bin/sh $HOME/baconTelegraph/ardop.sh
;;
   "Direwolf") \
/bin/sh $HOME/baconTelegraph/direwolf_src.sh
;;
   "XASTIR") \
/bin/sh $HOME/baconTelegraph/xastir_src.sh
;;
   "OP25") \
/bin/sh $HOME/baconTelegraph/op25_src.sh
;;
   "gpsTimeSync") \
/bin/sh $HOME/baconTelegraph/gpsTimeSync.sh
;;
   *) \
echo "Sorry, no selection made"
exit 0   
   ;;
esac
####Once More
/bin/sh install.sh
