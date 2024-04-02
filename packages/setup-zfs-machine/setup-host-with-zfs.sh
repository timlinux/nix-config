#!/usr/bin/env bash


#
# This script will automate the creation of a zfs pool and
# then set up nixos on it. It will COMPLETELY TRASH the
# disk.
#
# Tim Sutton, March 2024
#
# This script was heavily derived from these two sources 
# (my thanks to both!)
#
# https://github.com/Hoverbear-Consulting/flake/blob/89cbf802a0be072108a57421e329f6f013e335a6/packages/unsafe-bootstrap/unsafe-bootstrap.sh
# https://github.com/mcdonc/p51-thinkpad-nixos/blob/zfsvid/configuration.nix

set -e

BLUE=34
CYAN=36
RED=31

if [ "$EUID" -ne 0 ]
  then 
    echo "🛑Run this as SUDO!"
  exit
fi

beginswith() { case $2 in "$1"*) true;; *) false;; esac; }

lsblk -o name,mountpoint,size,uuid,vendor

if test -z "${TARGET_DEVICE}"; then
	TARGET_DEVICE=$(gum input --prompt "What is the target device? (TARGET_DEVICE): " --placeholder "/dev/nvme?n?")
        if beginswith "/dev/nvme" "$TARGET_DEVICE"; then
            TARGET_DEVICE="${TARGET_DEVICE}p"
        fi
fi
echo "Got \`$(gum style --foreground ${BLUE} "TARGET_DEVICE")=$(gum style --foreground ${CYAN} "${TARGET_DEVICE}")\`"

sgdisk -O $TARGET_DEVICE

gum style "
This will irrevocably destroy all data on \`TARGET_DEVICE=${TARGET_DEVICE}\`!!!

A FAT32 EFI system partition will be created as the first partition.

An zfs partition will be created as the second partition."

gum confirm "Are you ready to setup this host (including destroying all data on the disk)?" || (echo "Ok!" && exit 1)


gum style --bold --foreground "${RED}" "Destroying existing partitions on \`TARGET_DEVICE=${TARGET_DEVICE}\` in 10..."
sleep 1
gum style --bold --foreground "${RED}" "Formatting"

umount -r /mnt || true
umount -r "${TARGET_DEVICE}" || true
sgdisk --zap-all "${TARGET_DEVICE}"
sgdisk -o "${TARGET_DEVICE}"
partprobe || true

# Create a partition for /boot of 10GB formatted with FAT
sgdisk -n 0:0:+10G -t 0:ef00 -c 0:efi "${TARGET_DEVICE}"
mkfs.fat -F 32 "${TARGET_DEVICE}"1
fatlabel "${TARGET_DEVICE}"1 NIXBOOT

# Create a partition for / using the remaining space
sgdisk -n 2:0:0 -t 0:8300 -c 0:NIXROOT "${TARGET_DEVICE}" 

echo "Do you want to encrypt your disk? Typically you should only say no here if you plan to restart the host remotely / without user interaction."
ENCRYPT=$(gum choose "YES" "NO")
if [ "$ENCRYPT" == "YES" ]; then
  # Create an encrypted zpool
  zpool create -f \
        -o altroot="/mnt" \
 	-o ashift=12 \
	-o autotrim=on \
	-O compression=lz4 \
	-O acltype=posixacl \
	-O xattr=sa \
	-O relatime=on \
	-O normalization=formD \
	-O dnodesize=auto \
	-O encryption=aes-256-gcm \
	-O keylocation=prompt \
	-O keyformat=passphrase \
	-O mountpoint=none \
	NIXROOT "${TARGET_DEVICE}"2
else
  # Create an non encrypted zpool
  zpool create -f \
        -o altroot="/mnt" \
 	-o ashift=12 \
	-o autotrim=on \
	-O compression=lz4 \
	-O acltype=posixacl \
	-O xattr=sa \
	-O relatime=on \
	-O normalization=formD \
	-O dnodesize=auto \
	-O mountpoint=none \
	NIXROOT "${TARGET_DEVICE}"2
fi

zfs create -o mountpoint=legacy NIXROOT/root
zfs create -o mountpoint=legacy NIXROOT/home
zfs create -o mountpoint=legacy NIXROOT/nix
# reserved to cope with running out of disk space
zfs create -o refreservation=1G -o mountpoint=none NIXROOT/reserved
mount -t zfs NIXROOT/root /mnt
mkdir /mnt/boot
mkdir /mnt/home
mkdir /mnt/nix

mount "${TARGET_DEVICE}"1 /mnt/boot
mount -t zfs NIXROOT/home /mnt/home
mount -t zfs NIXROOT/nix /mnt/nix
nixos-generate-config --root /mnt


rpl " boot.loader.grub.enable = true;" "\n
  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid \n
  # for notes on how I set up zfs \n
  services.zfs.autoScrub.enable = true; \n
  boot.loader.grub.enable = true; \n
  boot.loader.grub.devices = [\"nodev\"]; \n
  boot.loader.grub.efiInstallAsRemovable = true; \n
  boot.loader.grub.efiSupport = true; \n
  boot.loader.grub.useOSProber = true; \n
  boot.supportedFilesystems = [\"zfs\"]; \n
  boot.zfs.requestEncryptionCredentials = true; \n
  networking.hostName = \"HOSTNAME\"; # Define your hostname. \n
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId \n
  # Generate using this: \n
  # head -c 8 /etc/machine-id \n
  networking.hostId = \"MACHINEID\"; # needed for zfs\n" /mnt/etc/nixos/configuration.nix

MACHINEID=$(head -c 8 /etc/machine-id)
rpl "MACHINEID" "${MACHINEID}" /mnt/etc/nixos/configuration.nix
HOSTNAME=$(gum input --prompt "What is hostname for this new machine?: " --placeholder "ROCK")
rpl "HOSTNAME" "${HOSTNAME}" /mnt/etc/nixos/configuration.nix

nixos-install 
