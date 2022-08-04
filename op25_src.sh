
#!/bin/bash
#########################################################
# Created by W7SVT AUG  2022 ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

echo "#########################" 
echo "# Download install OP25 #"
echo "#########################" 
sudo apt-get build-dep gnuradio
sudo apt update && sudo apt upgrade -y
    sudo apt install -y \
    gnuradio \
    gnuradio-dev \
    gr-osmosdr \
    librtlsdr-dev \
    libuhd-dev \
    libhackrf-dev \
    libitpp-dev \
    libpcap-dev \
    liborc-dev \
    cmake \
    git \
    swig \
    build-essential \
    pkg-config \
    doxygen \
    python3-numpy \
    python3-waitress \
    python3-requests \
    gnuplot-x11

git clone https://github.com/boatbod/op25.git
cd op25/
bash install.sh 

echo "##########################" 
echo "# Copy OP25 Conf to apps #"
echo "##########################" 

cp baconTelegraph/files/OP25_conf/* ~/op25/op25/gr-op25_repeater/apps

echo "########################" 
echo "# Create OP25 Script   #"
echo "########################" 

cat <<EOF > $HOME/op25/op25.sh
#! /bin/sh

cd ~/op25/op25/gr-op25_repeater/apps
./rx.py --args 'rtl' -N 'LNA:47' -S 2400000 -f 769.2812e6 -o 25000 -X -T trunk.>
xdg-open http://0.0.0.0:8080/

EOF

echo "##########################" 
echo "# Create aliase for OP25 #"
echo "##########################" 

cat <<EOF > $HOME/.bash_aliases
alias op25='bash /home/pi/op25/op25.sh'
EOF

