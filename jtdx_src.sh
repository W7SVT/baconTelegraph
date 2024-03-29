#!/bin/bash
#########################################################
# Created by W7SVT APR 2022 #############################
# Updated by W7SVT APR 2022 #############################
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
mkdir jtdx

echo "###################################################" 
echo "# Downloading JTDX Source                         #"
echo "###################################################" 

cd $HOME/Downloads/jtdx

jtdx_dl=159

wget https://github.com/jtdx-project/jtdx/archive/refs/tags/${jtdx_dl}.tar.gz -O - | tar -xz


mkdir JTDX_BLD_DIR


echo "###################################################"
echo "# Prepping JTDX build & prereqs                   #"
echo "###################################################"

sudo apt install -y \
	asciidoc \
  	asciidoctor \
	texinfo \
  	libfftw3-dev \
  	qtmultimedia5-dev \
  	qttools5-dev \
  	qttools5-dev-tools \
  	libqt5serialport5-dev \
	libqt5websockets5-dev \
	libqt5multimedia5 \
	libqt5multimedia5-plugins \
	qtmultimedia5-dev \
	libboost-dev \
	libboost-all-dev

sudo mkdir /usr/local/stow/jtdx_$jtdx_dl

echo "###################################################"
echo "# Installing JTDX in stow to remove run:          #"
echo "# 'cd /usr/local/stow/ && sudo stow -D jtdx'      #"
echo "###################################################"
cd $HOME/Downloads/jtdx/JTDX_BLD_DIR

cmake \
	-DWSJT_GENERATE_DOCS=OFF \
	-DWSJT_SKIP_MANPAGES=ON \
	-D CMAKE_INSTALL_PREFIX=/usr/local/stow/jtdx_$jtdx_dl" \
	../jtdx-${jtdx_dl}"

cmake --build ../JTDX_BLD_DIR -j$(nproc)

sudo cmake --install . --prefix /usr/local/stow/jtdx_$jtdx_dl
cd /usr/local/stow/ && sudo stow jtdx_$jtdx_dl

echo "###################################################"
echo "# get CALLSIGN & Grid                             #"
echo "###################################################"

if [ -n "$CALLSIGN" ]; then
dd of=$HOME/.config/JTDX.ini << EOF
[Configuration]
MyCall=$CALLSIGN
MyGrid=$GRID
EOF
else
	echo "Please (re)run install.sh and set your GRID and CALLSIGN"
fi
