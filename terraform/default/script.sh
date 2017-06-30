#!/usr/bin/env bash


sudo apt-get update -y
sudo apt-get install python-simplejson -y
sudo mkfs.ext4 /dev/xvdb
sudo mkdir -p /cache
sudo sed -i s/'\/mnt'/'\/cache'/g /etc/fstab
sudo mount -a
sudo reboot