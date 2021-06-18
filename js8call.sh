
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

js8call_dl=$(curl -sL http://files.js8call.com/latest.html | \
    tac | \
    grep armhf | \
    awk -F'"' '$0=$2'
)

#([^\/]+$)

cd $HOME/Downloads

if [ ! -f $HOME/Downloads/js8call_2.2.0_armhf.deb ]; then
    wget -t 5 $js8call_dl

fi

echo "#######################" 
echo "# Installing JS8CALL  #"
echo "#######################" 

sudo apt-get install $HOME/Downloads/js8call_*armhf.deb -y

