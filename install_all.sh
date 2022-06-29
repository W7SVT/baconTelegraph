
#!/bin/bash
#########################################################
# Created by W7SVT Jun 2021 #############################
# Updated by W7SVT Jun 2022
#########################################################
#########################################################
#  __      ___________  _____________   _______________ #
# /  \    /  \______  \/   _____/\   \ /   /\__    ___/ #
# \   \/\/   /   /    /\_____  \  \   Y   /   |    |    #
#  \        /   /    / /        \  \     /    |    |    #
#   \__/\  /   /____/ /_______  /   \___/     |____|    #
#        \/                   \/                        #
#########################################################

#**************************************************
# Elegant way to install everything               #
# Read app.list and install if not installed      #
# Note: its not bragging if you did it            #
#**************************************************




typeset f0=""
while IFS=: read -r f1 f2 f3; do
	app=$f1 path=$f2.sh bin=$f3
	f0="$f1"
    if ls $f3*$app* > /dev/null 2>&1
    then
        echo "$app is already installed"
    else
        echo "'$app' is installing"
        bash $HOME/baconTelegraph/$path
    fi

	sleep 1

done<app.list
echo $f0



