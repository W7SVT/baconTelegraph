
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

sudo apt-get update
sudo apt-get install conky-all -y

cd $HOME/.config


sudo cp /etc/conky/conky.conf .conkyrc

sudo chown ${USER:=$(/usr/bin/id -run)}:$USER .conkyrc

## Runat Startup
if [ ! -f $HOME/conkystartup.sh ]; then
    touch $HOME/conkystartup.sh
    echo 'sleep 10' >> $HOME/conkystartup.sh
    echo 'conky -b -c $HOME/.config/.conky_baconTelegraph &' >> $HOME/conkystartup.sh

fi

sudo chmod a+x $HOME/conkystartup.sh
cp $HOME/baconTelegraph/files/.conky_baconTelegraph $HOME/.config/
