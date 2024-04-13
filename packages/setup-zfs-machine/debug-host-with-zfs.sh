#!/usr/bin/env bash
set -e

BLUE=34
CYAN=36
RED=31

if [ "$EUID" -ne 0 ]
  then 
    echo "🛑Run this as SUDO!"
  exit
fi

read -d '\n' MESSAGE << EndOfText
This script is intended to be used to rescue a NixOS system
that has been installed with ZFS using the accompanying 
setup-host-with-zfs.sh script. 

It will mount the ZFS drives back in /mnt as it did during
the setup process and then put you in a chroot so you can 
explore and modify the files of the system you are rescuing.

Tim Sutton, March 2024
EndOfText

gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 80 --margin "1 2" --padding "2 4" \
  'About this script:' "${MESSAGE}"

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Current Mounts' $(sudo zfs list;sudo mount | grep NIXROOT;sudo mount | grep boot)

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Mounting' 'Mounting the partitions and ZFS datasets:

/mnt/boot
NIXROOT/root /mnt
NIXROOT/home /mnt/home
NIXROOT/nix  /mnt/nix
'

sudo zpool import -d /dev/vda2 -f NIXROOT
sudo zpool list
sudo zfs set mountpoint=/mnt NIXROOT/root
sudo chown -R root:root /mnt
echo "Is your ZFS Pool encrypted?"
ENCRYPT=$(gum choose "YES" "NO")
if [ "$ENCRYPT" == "YES" ]; then
  sudo zfs load-key NIXROOT
fi
sudo zfs mount NIXROOT/root
sudo zfs set mountpoint=/mnt/home NIXROOT/home
sudo zfs set mountpoint=/mnt/nix NIXROOT/nix
sudo mount /dev/vda1 /mnt/boot/
cd /mnt
sudo chroot ./ /nix/var/nix/profiles/system/activate
sudo chroot ./ /run/current-system/sw/bin/bash
rm /etc/resolv.conf
echo 'nameserver 1.1.1.1' > /etc/resolv.conf

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Current Mounts' $(sudo zfs list;sudo mount | grep NIXROOT;sudo mount | grep boot)

gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" \
  'Success' "Ok you are now in the chroot environment."


