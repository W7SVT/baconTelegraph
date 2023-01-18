
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
echo "# Prepping QSSTV build & prereqs                  #"
echo "###################################################"

qsstv_ver="qsstv_9.5"

qsstv_stow="/usr/local/stow/$qsstv_ver"

sudo mkdir $qsstv_stow

sudo apt-get install -y \
    libfftw3-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    libpulse-dev \
    libqt5svg5-dev \
    libqt5opengl5-dev \
    libhamlib-dev \
    libasound2-dev \
    libv4l-dev \
    libopenjp2-7 \
    libopenjp2-7-dev


git clone https://github.com/ON4QZ/QSSTV.git

echo "###################################################"
echo "# Installing QSSTV in stow                        #"
echo "# to remove run                                   #"
echo "# cd /usr/local/stow/&& sudo stow --delete QSSTV* #"
echo "###################################################"

cd QSSTV
mkdir src/build
cd src/build

qmake .. PREFIX=$qsstv_stow
make -j$(nproc)
sudo make install

cd $qsstv_stow/.. && sudo stow "$qsstv_ver"

echo "########################" 
echo "# Desktop Entry & Icon #"
echo "########################" 
sudo mkdir $qsstv_stow/share/applications
sudo mkdir $qsstv_stow/share

sudo dd of=$qsstv_stow/share/applications/qsstv.desktop << EOF
[Desktop Entry]
Name=QSSTV
Comment=Slow Scan TV
GenericName=QSSTV
Exec=/usr/local/bin/qsstv
Icon=$HOME/.local/share/icons/qsstv.png
Type=Application
Terminal=false
Categories=HamRadio;
EOF

cp $HOME/Downloads/QSSTV/src/icons/qsstv.png $HOME/.local/share/icons/