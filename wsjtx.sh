
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

sudo apt-get install $wsjtx_dl

echo "######################" 
echo "# Fixing locale      #"
echo "######################" 

sudo sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
sudo locale-gen
