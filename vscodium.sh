#!/bin/bash
#########################################################
# Created by W7SVT June 2022 ############################
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

#######################
# Are you 64 bit?     #
#######################

if [ `getconf LONG_BIT` = '64' ]; then
archDEB=arm64.deb
else
archDEB=armhf.deb
fi

#Grab url for Latest DEB 

codium_dl=$(curl -siL https://github.com/VSCodium/vscodium/releases/latest | 
tac |
grep $archDEB |
grep -v sha |
awk -F'"' '$0=$2' |
awk '$1<"\/"')

#Cleanup VAR to get file name
codium_ver=$(echo $codium_dl | awk '{sub("/[^:]*/","",$1); print $1,$2,$6,$7,$14,$15,$16}')


#Download from Github

wget -t5 https://github.com$codium_dl

#Install with dependicies
sudo apt update
sudo apt install $HOME/Downloads/$codium_ver

#cleanup

rm $HOME/Downloads/$codium_ver