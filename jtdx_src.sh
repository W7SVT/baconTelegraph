
#!/bin/bash
#########################################################
# Created by W7SVT APR 2022 #############################
# Created by W7SVT APR 2022 #############################
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


wget https://github.com/jtdx-project/jtdx/archive/refs/tags/${wsjtx_dl}.tar.gz -O - | tar -xz


mkdir JTDX_BLD_DIR


echo "###################################################"
echo "# Prepping JTDX build & prereqs                   #"
echo "###################################################"


sudo apt install -y \
	build-essential \
	gfortran \
	gcc \
	g++ \
	stow 

sudo apt install -y \
	cmake \
	git \
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
echo "# Installing JTDX in stow                         #"
echo "# to remove run 'sudo stow --delete jtdx'        #"
echo "###################################################"

cmake -D CMAKE_INSTALL_PREFIX=/usr/local/stow/jtdx "${jtdx_dl}"
cd JTDX_BLD_DIR
cmake "../${jtdx_dl}"
cd $HOME/Downloads/jtdx

cmake --build JTDX_BLD_DIR
sudo cmake --build JTDX_BLD_DIR --target install
cd /usr/local/stow/ && sudo stow wsjtx

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
