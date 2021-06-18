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

wget --tries 2 --connect-timeout=60 https://trac.chirp.danplanet.com/chirp_daily/LATEST/
CHIRPBUILD=$(cat index.html | grep .tar.gz | grep chirp-daily- | awk '{ print $6 }' | sed 's/.*"//' | sed 's/>//' | sed 's/[<].*$//')
sudo apt-get -y install python-gtk2 python-serial python-libxml2

mkdir $HOME/chirp
cd $HOME/chirp

wget --tries 2 --connect-timeout=60 https://trac.chirp.danplanet.com/chirp_daily/LATEST/$CHIRPBUILD
tar -xzf $CHIRPBUILD
CHIRPDIR=$(echo $CHIRPBUILD | sed 's/[.].*$//')
cd $CHIRPDIR
sudo python setup.py install
pip install future