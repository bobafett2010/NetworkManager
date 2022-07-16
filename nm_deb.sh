#!/bin/bash
#

FILE=/usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf
if test -f "$FILE";
then
    sudo mv /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf  /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf_orig
else
    echo "$FILE does not exist"
    
sudo touch /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf

FILE=/etc/NetworkManager/NetworkManager.conf
if test -f "$FILE";
then
    sudo sed -i 's/managed\=false/managed\=true/g' /etc/NetworkManager/NetworkManager.conf
else
    echo "$FILE does not exist"

sudo systemctl restart NetworkManager

sudo apt update && sudo apt install ifupdown
sudo apt --purge remove nplan netplan.io -y
sudo systemctl stop systemd-networkd
sudo systemctl stop systemd-networkd.socket
sudo systemctl disable systemd-networkd
sudo systemctl disable systemd-networkd.socket
sudo systemctl mask systemd-networkd
sudo systemctl mask systemd-networkd.socket

while true; do
   read -p "Would you like to reboot the system to make the changes take effect?" yn
   case ${yn:0:1} in
      [Yy]* ) 
          sudo reboot now
         fi
         break;;
      [Nn]* )
         echo "Please reboot to the system to allow changes to take effect"
         exit;;
      * ) echo "Please answer either Y/y or N/n";;
   esac
done
