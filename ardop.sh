
#!/bin/bash
#########################################################
# Created by W7SVT June 2021 ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

echo "#######################" 
echo "# Are you 64 bit?     #"
echo "#######################" 

if [ `getconf LONG_BIT` = '64' ]; then
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install -y libqt5widgets5:armhf libqt5serialport5:armhf libasound2:armhf libasound2-plugins:armhf
fi

echo "#######################" 
echo "# Download ARDOP HF   #"
echo "#######################" 

mkdir -p $HOME/ardop
cd $HOME/ardop
wget -t2 https://www.cantab.net/users/john.wiseman/Downloads/Beta/piardopc
sudo chmod +x $HOME/ardop/piardopc

echo "#######################" 
echo "# Download ARDOP HF GUI  #"
echo "#######################" 

wget -t2  https://www.cantab.net/users/john.wiseman/Downloads/Beta/piARDOP_GUI
sudo chmod +x $HOME/ardop/piARDOP_GUI

echo "#######################" 
echo "# ARDOP HF Entry      #"
echo "#######################" 

cat <<EOF > $HOME/.local/share/applications/ardopgui.desktop
[Desktop Entry]
Name=ARDOP GUI
GenericName=ARDOP GUI
Comment=GUI for ARDOP HF modem 
Exec=$HOME/ardop/piARDOP_GUI
Terminal=false
Type=Application
Categories=HamRadio;
EOF

echo "########################" 
echo "# Create Conf for ARDOP#"
echo "########################" 

mkdir -p $HOME/.config/G8BPQ

cat <<EOF > $HOME/.config/G8BPQ/ARDOP_GUI.conf
[General]
Host=local
Port=8515
EOF
