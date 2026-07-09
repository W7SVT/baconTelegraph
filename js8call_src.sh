
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


mkdir -p $HOME/Downloads/js8call

echo "###################################################" 
echo "# Downloading JS8Call Source                      #"
echo "###################################################" 

cd $HOME/Downloads/js8call

js8_tag=$(curl -s https://api.github.com/repos/js8call/js8call/releases/latest | grep -oP '"tag_name": ?"\K[^"]+')
js8_ver="${js8_tag#v}"
js8_stow="/usr/local/stow/"
js8_BLD="js8call_BLD_DIR"

wget -t 5 "https://github.com/js8call/js8call/archive/refs/tags/${js8_tag}.tar.gz" -O - | tar -xz

mkdir -p $js8_BLD


echo "###################################################"
echo "# Prepping JS8Call build & prereqs                   #"
echo "###################################################"


sudo apt install -y \
	asciidoc \
  	asciidoctor \
	texinfo \
  	libfftw3-dev \
	qt6-base-dev \
	qt6-multimedia-dev \
	qt6-serialport-dev \
	qt6-tools-dev \
	libboost1.81-all-dev

sudo mkdir -p "$js8_stow"js8call

echo "###################################################"
echo "# Installing JS8call in stow to remove run:       #"
echo "# 'cd /usr/local/stow/ && sudo stow -D js8call'   #"
echo "###################################################"

cd $js8_BLD && cmake -DWSJT_GENERATE_DOCS=OFF -DWSJT_SKIP_MANPAGES=ON "../js8call-$js8_ver"
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


