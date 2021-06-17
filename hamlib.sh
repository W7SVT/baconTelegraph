#!/bin/bash
#########################################################
# Created by W7SVT Nov 2020 #############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

cd $DIR
hamlib_DL=$(curl -sL https://api.github.com/repos/Hamlib/Hamlib/releases/latest | grep -o -m 1 "http.*tar.gz")
hamlib_ver=$(echo $hamlib_DL | sed -nr '/.*\-(.{,10}).*/s//\1/p' | sed -n '/\.tar\.gz$/s///p')
cd $HOME/Downloads

echo "######################" 
echo "# Downloading hamlib #"
echo "######################" 

wget $hamlib_DL

tar -xzf hamlib-$hamlib_ver.tar.gz
rm hamlib-$hamlib_ver.tar.gz
cd hamlib-$hamlib_ver

echo "######################" 
echo "# Installing  hamlib #"
echo "######################" 

./configure
make 
sudo make install
sudo ldconfig






