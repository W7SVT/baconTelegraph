
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

mkdir -p $HOME/.config/G8BPQ
touch $HOME/.config/G8BPQ/ARDOP_GUI.conf

echo "[General]"  >> $HOME/.config/G8BPQ/ARDOP_GUI.conf
echo "Host=local" >> $HOME/.config/G8BPQ/ARDOP_GUI.conf
echo "Port=8515" >> $HOME/.config/G8BPQ/ARDOP_GUI.conf
