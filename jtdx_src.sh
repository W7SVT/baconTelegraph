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

curl -s https://api.github.com/repos/Xastir/Xastir/releases/latest | \
	grep "tarball_url" | cut -d : -f 2,3

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

sudo mkdir /usr/local/stow/jtdx

echo "###################################################"
echo "# Installing JTDX in stow to remove run:          #"
echo "# 'cd /usr/local/stow/ && sudo stow -D jtdx'      #"
echo "###################################################"

#cmake -D CMAKE_INSTALL_PREFIX=/usr/local/stow/jtdx "jtdx-${jtdx_dl}"
cmake -DWSJT_GENERATE_DOCS=OFF -DWSJT_SKIP_MANPAGES=ON "../jtdx-${jtdx_dl}"
cd JTDX_BLD_DIR
cd $HOME/Downloads/jtdx

cmake --build JTDX_BLD_DIR -j$(nproc)

cd $HOME/Downloads/jtdx/JTDX_BLD_DIR && sudo cmake --install . --prefix /usr/local/stow/jtdx
cd /usr/local/stow/ && sudo stow jtdx

echo "###################################################"
echo "# get CALLSIGN & Grid                             #"
echo "###################################################"


if [ -n "$CALLSIGN" ]; then
cp -f /baconTelegraph/files/WSJT-X.ini $HOME/.config
sed -i "s/NOCALL/$CALLSIGN/g" $HOME/.config/WSJT-X.ini
sed -i "s/NOGRID/$GRID" $HOME/.config/WSJT-X.ini
else
  echo "Please (re)run install.sh and set your GRID and CALLSIGN" \
fi
