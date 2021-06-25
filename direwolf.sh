
#!/bin/bash
#########################################################
# Created by W7SVT June 2021 ############################
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################


echo "#######################" 
echo "# Download Direwolf   #"
echo "#######################" 

cd $HOME
git clone https://www.github.com/wb2osz/direwolf

echo "#######################" 
echo "# Install  Direwolf   #"
echo "#######################" 
cd $HOME/direwolf
mkdir build && cd build
cmake ..
make -j 4
sudo make install

echo "#######################" 
echo "# Conf Direwolf       #"
echo "#######################" 

make install-conf
sed -i "s/N0CALL/$CALL/" "$HOME/direwolf.conf"
sed -i 's/# ADEVICE  plughw:1,0/ADEVICE  plughw:2,0/' $HOME/direwolf.conf
sed -i '/#PTT\ \/dev\/ttyUSB0\ RTS/a #Uncomment line below for PTT with sabrent sound card\n#PTT RIG 2 localhost:4532' $HOME/direwolf.conf
rm -rf $HOME/direwolf