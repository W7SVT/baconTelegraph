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
echo "# Install prereq libusb-1.X #"
echo "#############################"

sudo apt-get install -y \
  libasound2-dev \
  cmake \
  libudev-dev

echo "############################" 
echo "# Set variables for latest #"
echo "############################" 

libusb_bzip_url=$(curl -sL https://api.github.com/repos/libusb/libusb/releases/latest |  grep -o -m 1 "http.*tar.bz2")
libusb_ver=$(basename "$libusb_bzip_url" .tar.bz2)

hamlib_tarball_url=$(curl -sL https://api.github.com/repos/Hamlib/Hamlib/releases/latest | grep -o -m 1 "http.*tar.gz")
hamlib_ver=$(basename "$hamlib_tarball_url" .tar.gz)

echo "#############################" 
echo "# Downloading libusb        #"
echo "#############################"
cd $HOME
wget $libusb_bzip_url -O - | tar -xj
cd $libusb_ver

echo "######################" 
echo "# Installing  libusb #"
echo "######################" 

./configure --prefix=/usr --disable-static && make
sudo make install
sudo ldconfig

echo "######################" 
echo "# Downloading hamlib #"
echo "######################" 

cd $HOME
wget $hamlib_tarball_url  -O - | tar -xz

cd $hamlib_ver

echo "######################" 
echo "# Installing  hamlib #"
echo "######################" 

./configure
make -j$(nproc) 
sudo make install
sudo ldconfig