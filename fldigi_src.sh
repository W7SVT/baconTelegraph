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
sudo apt-get install -y \
  libfltk1.3-dev \
  libportaudio2 \
  libpulse-dev \
  libsamplerate0-dev \
  libfftw3-dev \
  libltdl-dev \
  libjpeg-dev \
  libsndfile1-dev

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

echo "#############################" 
echo "# Downloading Fldigi        #"
echo "#############################"

cd $HOME

wget $fldigi_url"fldigi-"$fldigi_ver.tar.gz -O - | tar -xz

cd "fldigi-"$fldigi_ver

echo "#######################" 
echo "# Installing Fldigi   #"
echo "#######################"

./configure --prefix=/usr/local --enable-static
mkdir build
cd build
make .. -j$(nproc)
sudo make install
sudo make clean

echo "######################" 
echo "# Installation complete #"
echo "######################"

sudo ldconfig