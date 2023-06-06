
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

wfview_ver=$(curl -s https://gitlab.com/api/v4/projects/9269387/releases/ | \
    jq '.[]' | \
    jq -r '.name' | \
    head -1 | \
    sed -e 's/ v/_/g'
)

wfview_stow="/usr/local/stow/$wfview_ver"

sudo mkdir $wfview_stow

sudo apt-get install -y \
    build-essential \
    qt5-qmake \
    libqt5core5a \
    qtbase5-dev \
    libqt5serialport5 \
    libqt5serialport5-dev \
    libqt5multimedia5 \
    libqt5multimedia5-plugins \
    qtmultimedia5-dev \
    git \
    libopus-dev \
    libeigen3-dev \
    portaudio19-dev \
    librtaudio-dev \
    libhidapi-dev \
    libqt5gamepad5-dev


sudo apt-get install -y \
    libqcustomplot2.0 \
    libqcustomplot-doc \
    libqcustomplot-dev



mkdir $HOME/Downloads/wfview
cd $HOME/Downloads
git clone https://gitlab.com/eliggett/wfview.git
cd wfview
mkdir build
cd build
qmake ../wfview.pro PREFIX=$wfview_stow
make -j$(nproc)
sudo make install


cd $wfview_stow/.. && sudo stow "$wfview_ver"

