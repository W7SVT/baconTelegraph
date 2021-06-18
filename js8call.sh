
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
echo "# Downloading JS8CALL #"
echo "#######################" 

js8call_dl=$(curl -sL https://trac.chirp.danplanet.com/chirp_daily/LATEST/ | \
    tac | \
    grep -E '"chirp-daily-*[0-9]{8}.tar.gz"' | \
    awk -F'"' '$0=$8'
)

echo "#######################" 
echo "# Preping JS8CALL     #"
echo "#######################" 

mkdir $HOME/chirp
cd $HOME/chirp

echo "#######################" 
echo "# Installing  JS8CALL #"
echo "#######################" 

wget -t 5 https://trac.chirp.danplanet.com/chirp_daily/LATEST/$js8call_dl -O - | tar -xz
js8call_dir=$(echo $js8call_dl | | sed -n '/\.tar\.gz$/s///p')
cd $js8call_dir
sudo python setup.py install

echo "#######################" 
echo "# Might be nessasary  #"
echo "#######################" 

pip install future

