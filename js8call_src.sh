
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
mkdir js8call

echo "###################################################" 
echo "# Downloading JS8Call Source                      #"
echo "###################################################" 

cd $HOME/Downloads/js8call

js8call_dl=$(curl -s http://files.js8call.com/latest.html | \
    tac | \
    grep .tgz | \
    grep -v rc | \
    awk -F'"' '$0=$2'
)

js8call_ver="$(basename "$js8call_dl" .tgz)"


wget -t 5 $js8call_dl -O - | tar -xz

mkdir js8call_BLD_DIR


echo "###################################################"
echo "# Prepping JS8Call build & prereqs                   #"
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

sudo mkdir /usr/local/stow/js8call

echo "###################################################"
echo "# Installing JS8Call in stow                         #"
echo "# to remove run 'sudo stow --delete js8call'        #"
echo "###################################################"

cmake -D CMAKE_INSTALL_PREFIX=/usr/local/stow/js8call js8call
cmake -DWSJT_GENERATE_DOCS=OFF -DWSJT_SKIP_MANPAGES=ON js8call
cd js8call_BLD_DIR
cmake "../js8call"
cd $HOME/Downloads/js8call

cmake --build js8call_BLD_DIR
sudo cmake --build js8call_BLD_DIR --target install -j4
cd /usr/local/stow/ && sudo stow js8call

