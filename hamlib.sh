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

echo "#############################" 
echo "# Install prereq libusb-1.0.24  #"
echo "#############################"

sudo apt-get install -y \
  libasound2-dev \
  cmake \
  libudev-dev

cd $HOME
hamlib_DL=$(curl -sL https://api.github.com/repos/Hamlib/Hamlib/releases/latest | grep -o -m 1 "http.*tar.gz")
hamlib_ver=$(echo $hamlib_DL | sed -nr '/.*\-(.{,10}).*/s//\1/p' | sed -n '/\.tar\.gz$/s///p')

echo "#############################" 
echo "# Downloading libusb-1.0.24 #"
echo "#############################"

wget https://github.com/libusb/libusb/releases/download/v1.0.24/libusb-1.0.24.tar.bz2  -O - | tar -xj
cd libusb-1.0.24
./configure --prefix=/usr --disable-static && make
sudo make install

echo "######################" 
echo "# Downloading hamlib #"
echo "######################" 

wget $hamlib_DL  -O - | tar -xz

cd hamlib-$hamlib_ver

echo "######################" 
echo "# Installing  hamlib #"
echo "######################" 

./configure
make 
sudo make install
sudo ldconfig






