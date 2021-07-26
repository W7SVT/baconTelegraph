
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

echo "######################" 
echo "# Read/Set CALLSIGN  #"
echo "######################" 

if [ -n "$CALLSIGN" ]; then
  echo "Your CALLSIGN is set to '$CALLSIGN'"
  sed -i "s/NOCALL/$CALLSIGN/g" $HOME/baconTelegraph/files/.conky_baconTelegraph
else
  read  -r -p "What is your CALLSIGN?:" GRID
  sudo echo "export CALLSIGN=$CALLSIGN" >> $HOME/.bashrc
fi
sleep 1


echo "######################" 
echo "# Read/Set GRID      #"
echo "######################" 


if [ -n "$GRID" ]; then
  echo "Your GRID is set to '$GRID'"
  touch $HOME/.config/grid
  truncate -s 0 $HOME/.config/grid
  echo $GRID >> $HOME/.config/grid
else
  read  -r -p "What is your GRID?:" GRID
  sudo echo "export GRID=$GRID" >> $HOME/.bashrc
fi
sleep 1

echo "#######################" 
echo "# Downloading conky   #"
echo "#######################" 

sudo apt-get update
sudo apt-get install conky-all -y

cd $HOME/.config


sudo cp /etc/conky/conky.conf .conkyrc

sudo chown ${USER:=$(/usr/bin/id -run)}:$USER .conkyrc

sudo chmod a+x $HOME/conkystartup.sh
cp $HOME/baconTelegraph/files/.conky_baconTelegraph_SM_Screen $HOME/.config/

echo "#######################" 
echo "# Desktop Entry conky #"
echo "#######################" 

cat <<EOF > $HOME/.local/share/applications/conky.desktop
[Desktop Entry]
Name=Conky
Comment=Conky
GenericName=Conky Screen Background Monitor
Exec=sh -c "sleep 10; conky -b -c $HOME/.config/.conky_baconTelegraph_SM_Screen;"
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


if [ ! -d $HOME/.config/autostart ]; then
    mkdir -p $HOME/.config/autostart
fi

ln -sf $HOME/.local/share/applications/conky.desktop $HOME/.config/autostart/conky.desktop

echo "#######################" 
echo "# Install Fonts       #"
echo "#######################" 

if [ ! -d $HOME/.fonts ]; then
    mkdir -p $HOME/.fonts
fi
cp $HOME/baconTelegraph/fonts/*.ttf  $HOME/.fonts/
fc-cache -v -f



