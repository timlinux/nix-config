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

lsblk -o name,mountpoint,size,uuid,vendor

if test -z "${TARGET_DEVICE-}"; then
	TARGET_DEVICE=$(gum input --prompt "What is the target device? (TARGET_DEVICE): " --placeholder "/dev/nvme?n?")
fi
echo "Got \`$(gum style --foreground ${BLUE} "TARGET_DEVICE")=$(gum style --foreground ${CYAN} "${TARGET_DEVICE}")\`"

gum style "
This will irrevocably destroy all data on \`TARGET_DEVICE=${TARGET_DEVICE-/dev/null}\`!!!

A FAT32 EFI system partition will be created as the first partition.

An zfs partition will be created as the second partition.

gum confirm "Are you ready to setup this host (including destroying all data on the disk)?" || (echo "Ok!" && exit 1)


gum style --bold --foreground "${RED}" "Destroying existing partitions on \`TARGET_DEVICE=${TARGET_DEVICE}\` in 10..."
sleep 10
gum style --bold --foreground "${RED}" "Formatting"

umount -r /mnt || true
umount -r "${TARGET_DEVICE}" || true
sgdisk --zap-all "${TARGET_DEVICE}"
sgdisk -o "${TARGET_DEVICE}"
partprobe || true

# Create a partition for /boot of 10GB formatted with FAT
sgdisk "${TARGET_DEVICE}" -n 1:0:+10G
sgdisk "${TARGET_DEVICE}" -t 1:ef00
sgdisk "${TARGET_DEVICE}" -c 1:efi
mkfs.fat -F 32 "${TARGET_DEVICE}"p1
fatlabel "${TARGET_DEVICE}"p1 NIXBOOT

# Create a partition for / using the remaining space
sgdisk "${TARGET_DEVICE}" -n 2:0:0
sgdisk "${TARGET_DEVICE}" -t 2:8309
sgdisk "${TARGET_DEVICE}" -c 2:encrypt

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
	NIXROOT "${TARGET_DEVICE}"p2
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
	NIXROOT "${TARGET_DEVICE}"p2
fi

zfs create -o mountpoint=legacy NIXROOT/root
zfs create -o mountpoint=legacy NIXROOT/home
# reserved to cope with running out of disk space
zfs create -o refreservation=1G -o mountpoint=none NIXROOT/reserved
mount -t zfs NIXROOT/root /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount "${TARGET_DEVICE}"p1 /mnt/boot
mount -t zfs NIXROOT/home /mnt/home
nixos-generate-config --root /mnt
nixos-install 
