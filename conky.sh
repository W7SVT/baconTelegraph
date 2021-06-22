
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

cd $HOME/Downloads

echo "#######################" 
echo "# Downloading conky   #"
echo "#######################" 

sudo add-apt-repository ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install conky-all conky-manager -y

cd ~/.config


sudo cp /etc/conky/conky.conf .conkyrc

sudo chown ${USER:=$(/usr/bin/id -run)}:$USER .conkyrc

## Runat Startup
touch ~/conkystartup.sh
sudo chmod a+x ~/conkystartup.sh
echo 'sleep 10' >> ~/conkystartup.sh
echo 'conky -b -c ~/.config/.conky_baconTelegraph &' >> ~/conkystartup.sh

cp ~/home/pi/files/baconTelegraph/.conky_baconTelegraph ~/.config/
