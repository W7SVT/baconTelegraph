
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

mkdir -p "$HOME/Downloads"
cd "$HOME/Downloads"

wfview_ver=$(curl -s https://gitlab.com/api/v4/projects/9269387/releases/ | jq -r '.[0].tag_name' | sed -e 's/^v//')

wfview_stow="/usr/local/stow/wfview_$wfview_ver"

sudo mkdir -p "$wfview_stow"

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
    jq \
    libopus-dev \
    libeigen3-dev \
    portaudio19-dev \
    librtaudio-dev \
    libhidapi-dev \
    libqt5gamepad5-dev


sudo apt-get install -y \
    libqcustomplot2.1 \
    libqcustomplot-doc \
    libqcustomplot-dev



mkdir -p $HOME/Downloads/wfview
cd $HOME/Downloads
git clone https://gitlab.com/eliggett/wfview.git
cd wfview
mkdir -p build
cd build
qmake ../wfview.pro PREFIX="$wfview_stow"
make -j$(nproc)
sudo make install


cd "$wfview_stow/.." && sudo stow "wfview_$wfview_ver"

sudo usermod -aG dialout $USER