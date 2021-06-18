
#!/bin/bash
#########################################################
# Created by W7SVT Oct 2021 #############################
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
echo "# Downloading CHIRP #"
echo "#######################" 

CHIRP_dl=$(curl -sL https://trac.chirp.danplanet.com/chirp_daily/LATEST/ | \
    tac | \
    grep -E '"chirp-daily-*[0-9]{8}.tar.gz"' | \
    awk -F'"' '$0=$8'
)

echo "#######################" 
echo "# Preping CHIRP     #"
echo "#######################" 

mkdir $HOME/chirp
cd $HOME/chirp

echo "#######################" 
echo "# Installing  CHIRP #"
echo "#######################" 

wget -t 5 https://trac.chirp.danplanet.com/chirp_daily/LATEST/$CHIRP_dl -O - | tar -xz
CHIRP_dir=$(echo $CHIRP_dl | | sed -n '/\.tar\.gz$/s///p')
cd $CHIRP_dir
sudo python setup.py install

echo "#######################" 
echo "# Might be nessasary  #"
echo "#######################" 

pip install future

