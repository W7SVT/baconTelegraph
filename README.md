# baconTelegraph
ba·con  (bā′kən)
n.<br>
1. The salted and smoked meat from the back and sides of a pig. <br> 
~~2.~~ 1. Proof that God exists and he loves us.  

tel·e·graph  (tĕl′ĭ-grăf′) (from Ancient Greek: τῆλε, têle, "at a distance")
n.<br>
1. To send or convey a message to (a recipient) by telegraph.
1. To give advance notice of.
   1. To make known (a feeling or an attitude, for example) by nonverbal means: telegraphed her derision with a smirk.
   1. To make known (an intended action, for example) in advance or unintentionally:

### Assumptions
A SBC (Single Board Computer) Though initialy designed for Raspberry Pi 4 we has expanded to many others.
Fresh install of ARM64 or ARMHF OS preferable RaspberryPi OS Bullseye, though Buster is still supported until breaking changes
<br>Love of Ham Radio

### Install
```
git clone https://github.com/W7SVT/baconTelegraph.git  ~/baconTelegraph && /bin/sh ~/baconTelegraph/install.sh
```

#### Note: Once you have installed everything you would like a reboot is nessasary
### CLI Enable I2C port:

sudo raspi-config nonint do_i2c 0

echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$USER-for-sudo-password"

