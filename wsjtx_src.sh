
#!/bin/bash
#########################################################
# Created by W7SVT Nov 2021 #############################
# Updated by W7SVT JAN 2023 #############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

mkdir $HOME/Downloads/wsjtx

echo "###################################################" 
echo "# Downloading WSJT-X Source                       #"
echo "###################################################" 

wsjtx_ver=$(curl -qsL "https://sourceforge.net/projects/wsjt/best_release.json" | \
	sed "s/, /,\n/g" | \
	sed -rn "/release/,/\}/{ /filename/{ 0,//s/([^0-9]*)([0-9\.]+)([^0-9]*.*)/\2/ p }}"
	)


wsjtx_stow="/usr/local/stow/"
wsjtx_BLD="wsjtx_BLD_DIR"

cd $HOME/Downloads/wsjtx

wget -t 5 https://sourceforge.net/projects/wsjt/files/wsjtx-$wsjtx_ver/wsjtx-$wsjtx_ver.tgz -O - | tar -xz



echo "###################################################"
echo "# Prepping WSXJ-X build & prereqs                 #"
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


sudo mkdir "$wsjtx_stow"wsjtx-"$wsjtx_ver"


tar xzf wsjtx-$wsjtx_ver/src/wsjtx.tgz 

mv wsjtx $wsjtx_BLD


echo "###################################################"
echo "# Installing WSXJ-X in stow                              #"
echo "# to remove run                                          #"
echo "# cd /usr/local/stow/&& sudo stow --delete wsjtx*        #"
echo "###################################################"

cd $wsjtx_BLD
cmake \
	-DWSJT_SKIP_MANPAGES=ON \
	-DWSJT_GENERATE_DOCS=OFF \
	-D CMAKE_INSTALL_PREFIX="$wsjtx_stow"wsjtx-"$wsjtx_ver" "${wsjtx_dl%.*}"

cmake --build . --parallel$(nproc)
sudo cmake --build . --target install
cd $wsjtx_stow && sudo stow wsjtx-"$wsjtx_ver"

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
