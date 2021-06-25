
#!/bin/bash
#########################################################
# Created by W7SVT Nov 2021 #############################
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
echo "# Downloading JTDX #"
echo "######################" 
# TODO: Scrape is broken
# jtdx_dl=$(curl -sL https://www.jtdx.tech/downloads/ | \
#     tac | \
#     grep armhf.deb | \
#     grep -v rc | \
#     awk -F'"' '$0=$2'
# )
cd $HOME/Downloads


if [ ! -f $HOME/Downloads/jtdx-2.2.0-rc155_r_armhf.deb ]; then
    wget -t 5 https://www.jtdx.tech/downloads/Linux/jtdx-2.2.0-rc155_r_armhf.deb

fi

echo "######################" 
echo "# Installing JTDX  #"
echo "######################" 

sudo apt-get install $HOME/Downloads/jtdx-2.2.0-rc155_r_armhf.deb -y

echo "######################" 
echo "# default config JTDX  #"
echo "######################" 


## get CALLSIGN

if [ -n "$CALLSIGN" ]; then
cp -f /baconTelegraph/files/JTDX.ini $HOME/.config
sed -i "s/NOCALL/$CALLSIGN/g" $HOME/.config/JTDX.ini
sed -i "s/NOGRID/$GRID" $HOME/.config/JTDX.ini
else
  echo "Please (re)run install.sh and set your GRID and CALLSIGN" \
fi


