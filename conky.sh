
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

cd $HOME/Downloads

echo "#######################" 
echo "# Downloading conky   #"
echo "#######################" 

sudo apt-get update
sudo apt-get install conky-all -y

cd $HOME/.config


sudo cp /etc/conky/conky.conf .conkyrc

sudo chown ${USER:=$(/usr/bin/id -run)}:$USER .conkyrc

## Runat Startup
if [ ! -f $HOME/conkystartup.sh ]; then
    touch $HOME/conkystartup.sh
    echo 'sleep 10' >> $HOME/conkystartup.sh
    echo 'conky -b -c $HOME/.config/.conky_baconTelegraph &' >> $HOME/conkystartup.sh

fi

sudo chmod a+x $HOME/conkystartup.sh
cp $HOME/baconTelegraph/files/.conky_baconTelegraph $HOME/.config/

echo "#######################" 
echo "# Desktop Entry conky #"
echo "#######################" 

cat <<EOF > $HOME/.local/share/applications/conky.desktop
[Desktop Entry]
Name=Conky
Comment=Conky
GenericName=Conky Screen Background Monitor
Exec=conky
Icon=$HOME/baconTelegraph/files/conky.png
Type=Application
Encoding=UTF-8
Terminal=false
Categories=HamRadio
Keywords=Radio
EOF

echo "#######################" 
echo "# Autostart conky     #"
echo "#######################" 

ln -sf $HOME/.local/share/applications/conky.desktop $HOME/.config/autostart/conky.desktop



