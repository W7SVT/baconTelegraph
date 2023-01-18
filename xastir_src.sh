
#!/bin/bash
#########################################################
# Created by W7SVT Jan, 2023 ############################
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

echo "###################################################"
echo "# Prepping XASTIR build & prereqs                 #"
echo "###################################################"

xastir_ver=$(curl -s https://api.github.com/repos/Xastir/Xastir/releases/latest | \
grep "tarball_url" | \
sed 's/..$//' | \
cut -d - -f2,3 
)

xastir_stow="/usr/local/stow/xastir_$xastir_ver"

sudo mkdir $xastir_stow

sudo apt-get install -y \
    automake \
    xorg-dev \
    libmotif-dev \
    graphicsmagick \
    gv \
    libcurl4-openssl-dev \
    shapelib \
    libshp-dev \
    libpcre3-dev \
    libproj-dev \
    libdb-dev \
    libax25-dev \
    libwebp-dev \
    libwebp-dev \
    libgraphicsmagick1-dev \
    festival \
    festival-dev


git clone https://github.com/Xastir/Xastir.git

echo "####################################################"
echo "# Installing XASTIR in stow to remove run          #"
echo "# cd /usr/local/stow/&& sudo stow --delete xastir* #"
echo "####################################################"

cd Xastir
./bootstrap.sh
mkdir build
cd build 
../configure --prefix=$xastir_stow
make -j$(nproc)
sudo make install

sudo rm $xastir_stow/share/xastir/maps/CC_OpenStreetMap.png



sudo mkdir $xastir_stow/share/applications

echo "########################" 
echo "# Desktop Entry & Icon #"
echo "########################" 

sudo dd of=$xastir_stow/share/applications/xastir.desktop << EOF 
[Desktop Entry]
Name=Xastir
Comment=X Amateur Station Tracking and Information Reporting
Exec=xastir
Icon=$HOME/.local/share/icons/xastir.png
Terminal=false
Type=Application
Categories=HamRadio
Keywords=APRS;HamRadio
EOF

echo "####################################################"
echo "# Stowing XASTIR to remove run                     #"
echo "# cd /usr/local/stow/&& sudo stow --delete xastir* #"
echo "####################################################"

cp $HOME/Downloads/Xastir/symbols/icon.png $HOME/.local/share/icons/

mv $HOME/.local/share/icons/icon.png $HOME/.local/share/icons/xastir.png

cd $xastir_stow/.. && sudo stow "xastir_$xastir_ver"