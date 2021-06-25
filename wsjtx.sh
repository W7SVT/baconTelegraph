
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
echo "# Downloading WSJT-X #"
echo "######################" 

wsjtx_dl=$(curl -s https://physics.princeton.edu/pulsar/k1jt/wsjtx.html | \
    tac | \
    grep armhf.deb | \
    grep -v rc | \
    awk -F'"' '$0=$2'
)

cd $HOME/Downloads

wget -t 5 https://physics.princeton.edu/pulsar/k1jt/$wsjtx_dl

echo "######################" 
echo "# Installing WSXJ-X  #"
echo "######################" 

sudo apt-get install $HOME/Downloads/$wsjtx_dl -y

echo "######################" 
echo "# Fixing locale      #"
echo "######################" 

sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
sudo locale-gen

## get CALLSIGN

if [ -n "$CALLSIGN" ]; then
cp -f /baconTelegraph/files/WSJT-X.ini $HOME/.config
sed -i "s/NOCALL/$CALLSIGN/g" $HOME/.config/WSJT-X.ini
sed -i "s/NOGRID/$GRID" $HOME/.config/WSJT-X.ini
else
  echo "Please (re)run install.sh and set your GRID and CALLSIGN" \
fi
