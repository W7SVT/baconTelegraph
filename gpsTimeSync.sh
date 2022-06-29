
#!/bin/bash
#########################################################
# Created by W7SVT July 2021 #############################
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

echo "##############################" 
echo "# Downloading GPSD & chrony  #"
echo "##############################" 

sudo apt-get install -y \
    gpsd \
    chrony \
    gpsd-clients \
    python3-gps \
    python3-gi-cairo 



echo "##############################" 
echo "# Setting chrony config #"
echo "##############################" 

cat >chrony.conf <<EOF
# Welcome to the chrony configuration file. See chrony.conf(5) for more
# information about usuable directives.
# Mods By W7SVT

pool 2.debian.pool.ntp.org iburst

# Location of ID/key pairs for NTP auth.
keyfile /etc/chrony/chrony.keys

# Location chronyd will store the rate information.
driftfile /var/lib/chrony/chrony.drift

# Location of log.
logdir /var/log/chrony

# Limit bad estimates effect on HW clock.
maxupdateskew 100.0

# Enable kernel synchronisation with RTC 
rtcsync

# Step the system clock if out more then one second, in the first 3 updates
makestep 1 3

# Make GPS an option in the sources but not the primary one
refclock SHM 0 offset 0.5 delay 0.2 refid NMEA
EOF

sudo mv /etc/chrony/chrony.conf /etc/chrony/chrony.conf.bak
sudo mv chrony.conf /etc/chrony/chrony.conf

echo "##############################" 
echo "# Setting GPSD config #"
echo "##############################" 


cat >gpsd <<EOF
# Default settings for the gpsd init script and the hotplug wrapper.
# Mods By W7SVT

# Start the gpsd daemon automatically at boot time
START_DAEMON="true"

# Use USB hotplugging to add new USB devices automatically to the daemon
USBAUTO="false"

# Devices gpsd should collect to at boot time.
# They need to be read/writeable, either by user gpsd or the group dialout.
DEVICES="/dev/ttyACM0"

# Other options you want to pass to gpsd
GPSD_OPTIONS="-n -b"
EOF

sudo mv /etc/default/gpsd /etc/default/gpsd.bak
sudo mv gpsd /etc/default/gpsd

echo "#######################" 
echo "# Time Sync           #"
echo "#######################" 

    cat >timeSync.desktop <<EOF
[Desktop Entry]
Name=TimeSync
GenericName=TimeSync
Comment=NEMA and NTP Pool Time Sync
Exec=sudo chronyc makestep
Icon=/usr/share/icons/
Terminal=False
Type=Application
Categories=System
EOF

    sudo mv timeSync.desktop /usr/share/applications/

echo "##############################" 
echo "# You will need to reboot    #"
echo "# For changes to take effect #"
echo "##############################" 

