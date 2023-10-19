#!/bin/bash
#########################################################
# Created by W7SVT Nov 2020 #############################
# UPdated by W7SVT Oct 2023 #############################
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
echo "# Install dependencies      #"
echo "#############################"

sudo apt-get update

# Check if the system is running a 64-bit or 32-bit OS
if [ "$(uname -m)" == "x86_64" ]; then
    libjpegVER=libjpeg62-turbo-dev
elif [ "$(uname -m)" == "i686" ] || [ "$(uname -m)" == "i386" ]; then
    libjpegVER=libjpeg9-dev
else
    echo "Unable to determine the OS architecture."
fi

# Check if the system is Raspberry Pi 4
if grep -q "Raspberry Pi 4" /proc/cpuinfo; then
    optim=rpi4
else
    optim=native
fi

sudo apt-get install -y \
  libfftw3-dev \
  libfltk1.3-dev \
  $libjpegVER \
  libjpeg-dev \
  libltdl-dev \
  libpulse-dev \
  libsamplerate0-dev \
  libsndfile1-dev \
  libudev-dev \
  libxcursor-dev \
  libxft-dev \
  libxinerama-dev \
  portaudio19-dev \
  texinfo

sudo usermod -a -G dialout pi

echo "#############################" 
echo "# Set variables for Fldigi  #"
echo "#############################"

#fldigi_ver=$(curl -s https://api.github.com/repos/w1hkj/fldigi/tags | jq -r '.[0].name')

fldigi_url="http://www.w1hkj.com/files/fldigi/"

fldigi_ver=$(wget -qO- $fldigi_url | \
  grep -o 'href="fldigi-[0-9]\+\.[0-9]\+\.[0-9]\+\.tar\.gz"' | \
  cut -d'"' -f2 | \
  tail -n 1 | \
  sed -E 's/fldigi-([0-9]+\.[0-9]+\.[0-9]+)\.tar\.gz/\1/')

flrig_url="http://www.w1hkj.com/files/flrig/"

flrig_ver=$(wget -qO- $flrig_url | \
  grep -o 'href="flrig-[0-9]\+\.[0-9]\+\.[0-9]\+\.tar\.gz"' | \
  cut -d'"' -f2 | \
  tail -n 1 | \
  sed -E 's/flrig-([0-9]+\.[0-9]+\.[0-9]+)\.tar\.gz/\1/')

echo "#############################" 
echo "# Downloading Fldigi FLrig  #"
echo "#############################"

cd $HOME
wget $fldigi_url"fldigi-"$fldigi_ver.tar.gz -O - | tar -xz
wget $flrig_url"flrig-"$flrig_ver.tar.gz -O - | tar -xz

echo "#######################" 
echo "# Installing Fldigi   #"
echo "#######################"
cd $HOME
cd "fldigi-"$fldigi_ver
./configure --prefix=/usr/local --enable-static --enable-optimizations=$optim
make .. -j$(nproc)
sudo make install
sudo make clean

echo "#######################" 
echo "# Installing Flrig    #"
echo "#######################"
cd $HOME
cd "flrig-"$flrig_ver
./configure --prefix=/usr/local --enable-static --enable-optimizations=$optim
make .. -j$(nproc)
sudo make install
sudo make clean

echo "######################" 
echo "# Installation complete #"
echo "######################"

sudo ldconfig