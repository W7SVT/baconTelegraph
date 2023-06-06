
#!/bin/bash
#########################################################
# Created by W7SVT APR 2022 #############################
# Updated by W7SVT JUN 2023 #############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################


mkdir $HOME/Downloads/js8call

echo "###################################################" 
echo "# Downloading JS8Call Source                      #"
echo "###################################################" 

cd $HOME/Downloads/js8call

js8_dl=$(curl -s http://files.js8call.com/latest.html | \
    tac | \
    grep .tgz | \
    grep -v rc | \
    awk -F'"' '$0=$2'
)

js8_ver="$(basename "$js8_dl" .tgz)"
js8_stow="/usr/local/stow/"
js8_BLD="js8call_BLD_DIR"

wget -t 5 $js8_dl -O - | tar -xz

mkdir $js8_BLD


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

sudo mkdir "$js8_stow"js8call

echo "###################################################"
echo "# Installing JS8call in stow to remove run:       #"
echo "# 'cd /usr/local/stow/ && sudo stow -D js8call'   #"
echo "###################################################"

cmake -DWSJT_GENERATE_DOCS=OFF -DWSJT_SKIP_MANPAGES=ON js8call
cd $js8_BLD && cmake "../js8call"
cd $HOME/Downloads/js8call

cmake --build js8call_BLD_DIR -j$(nproc)
cd $HOME/Downloads/js8call/$js8_BLD && sudo cmake --install . --prefix "$js8_stow"js8call

cd /usr/local/stow/ && sudo stow js8call

echo "###################################################"
echo "# get CALLSIGN & Grid                             #"
echo "###################################################"

if [ -n "$CALLSIGN" ]; then
dd of=$HOME/.config/JS8Call.ini << EOF
[Configuration]
MyCall=$CALLSIGN
MyGrid=$GRID
EOF
else
	echo "Please (re)run install.sh and set your GRID and CALLSIGN"
fi


