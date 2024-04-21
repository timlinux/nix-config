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


# Choose
export GUM_CHOOSE_CURSOR_FOREGROUND="#F1C069"
export GUM_CHOOSE_HEADER_FOREGROUND="#F1C069"
export GUM_CHOOSE_ITEM_FOREGROUND="#F1C069"
export GUM_CHOOSE_SELECTED_FOREGROUND="#F1C069"
export GUM_CHOOSE_HEIGHT=10
export GUM_CHOOSE_CURSOR="👉️"
export GUM_CHOOSE_HEADER="Choose one:"
export GUM_CHOOSE_CURSOR_PREFIX="❓️"
export GUM_CHOOSE_SELECTED_PREFIX="👍️"
export GUM_CHOOSE_UNSELECTED_PREFIX="⛔️"
export GUM_CHOOSE_SELECTED=""
export GUM_CHOOSE_TIMEOUT=30
# Style
export FOREGROUND="#F1C069"
export BACKGROUND="#1F1F1F"
export BORDER="rounded"
export BORDER_BACKGROUND="#1F1F1F"
export BORDER_FOREGROUND="#F1C069"
#ALIGN="left"
export HEIGHT=3
export WIDTH=80
export MARGIN=1
export PADDING=2
#BOLD
#FAINT
#ITALIC
#STRIKETHROUGH
#UNDERLINE
# Confirm
export GUM_CONFIRM_PROMPT_FOREGROUND="#F1C069"
export GUM_CONFIRM_SELECTED_FOREGROUND="#F1C069"
export GUM_CONFIRM_UNSELECTED_FOREGROUND="#F1C069"
export GUM_CONFIRM_TIMEOUT=30s
# Input
export GUM_INPUT_PLACEHOLDER="-----------"
export GUM_INPUT_PROMPT=">"
export GUM_INPUT_CURSOR_MODE="blink"
export GUM_INPUT_WIDTH=40
export GUM_INPUT_HEADER="💬"
export GUM_INPUT_TIMEOUT=30s
export GUM_INPUT_PROMPT_FOREGROUND="#F1C069"
export GUM_INPUT_CURSOR_FOREGROUND="#F1C069"
export GUM_INPUT_HEADER_FOREGROUND="#F1C069"
# Spin
export GUM_SPIN_SPINNER_FOREGROUND="#F1C069"
export GUM_SPIN_TITLE_FOREGROUND="#F1C069"
# Table
export GUM_TABLE_BORDER_FOREGROUND="#F1C069"
export GUM_TABLE_CELL_FOREGROUND="#F1C069"
export GUM_TABLE_HEADER_FOREGROUND="#F1C069"
export GUM_TABLE_SELECTED_FOREGROUND="#F1C069"
# Filter
export GUM_FILTER_INDICATOR="👉️"
export GUM_FILTER_SELECTED_PREFIX="💎"
export GUM_FILTER_UNSELECTED_PREFIX=""
export GUM_FILTER_HEADER="Chooser"
export GUM_FILTER_PLACEHOLDER="."
export GUM_FILTER_PROMPT="Select an option:"
#export GUM_FILTER_WIDTH
#export GUM_FILTER_HEIGHT
#export GUM_FILTER_VALUE
#export GUM_FILTER_REVERSE
#export GUM_FILTER_FUZZY
#export GUM_FILTER_SORT
export GUM_FILTER_TIMEOUT=30s

export GUM_FILTER_INDICATOR_FOREGROUND="#F1C069"
export GUM_FILTER_SELECTED_PREFIX_FOREGROUND="#F1C069"
export GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND="#F8E3BD"
export GUM_FILTER_HEADER_FOREGROUND="#F1C069"
export GUM_FILTER_TEXT_FOREGROUND="#F1C069"
export GUM_FILTER_CURSOR_TEXT_FOREGROUND="#F1C069"
export GUM_FILTER_MATCH_FOREGROUND="#F1C069"
export GUM_FILTER_PROMPT_FOREGROUND="#F1C069"

if [ "$EUID" -ne 0 ]
  then 
    echo "🛑Run this as SUDO!"
  exit
fi

beginswith() { case $2 in "$1"*) true;; *) false;; esac; }

set +e
read -d '\n' LOGO << EndOfText

----------------------------------------------------------------------------

██╗  ██╗ █████╗ ██████╗ ████████╗ ██████╗ ███████╗ █████╗             
██║ ██╔╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗╚══███╔╝██╔══██╗            
█████╔╝ ███████║██████╔╝   ██║   ██║   ██║  ███╔╝ ███████║            
██╔═██╗ ██╔══██║██╔══██╗   ██║   ██║   ██║ ███╔╝  ██╔══██║            
██║  ██╗██║  ██║██║  ██║   ██║   ╚██████╔╝███████╗██║  ██║            
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝            
                                                                      
███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗    ███████╗███████╗███████╗    
████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ╚══███╔╝██╔════╝██╔════╝    
██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗      ███╔╝ █████╗  ███████╗    
██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║     ███╔╝  ██╔══╝  ╚════██║    
██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ███████╗██║     ███████║    
╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝     ╚══════╝    
                                                                      
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗ 
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝

EndOfText
# Above text generated at https://manytools.org/hacker-tools/ascii-banner/
# Using ANSI Shadow font
echo "$LOGO"
set -e

HOSTNAME=$(gum input --prompt "What is hostname for this new machine?: " --placeholder "ROCK")
hostname ${HOSTNAME}
echo "Are you installing an existing flake profile for $HOSTNAME?"
FLAKE=$(gum choose "YES" "NO")

# Function to prompt user to select a block device
if test -z "${TARGET_DEVICE}"; then
  echo "Available block devices:"
  lsblk -o name,mountpoint,size,uuid,vendor
  echo ""
  echo "Confirm which to use:"
  TARGET_DEVICE=/dev/$(gum choose $(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep 'disk' | awk '{print $1}'))
fi
echo "Got \`$(gum style --foreground ${BLUE} "TARGET_DEVICE")=$(gum style --foreground ${CYAN} "${TARGET_DEVICE}")\`"

sgdisk -O $TARGET_DEVICE

gum style "
Do you want to destroy the partitions or use them 'as is'? 
If you plan to use them as is, there should be the following
partitions and zpools on the device:

Partition 1 should be a FAT32 partition that is EFI (ef00).

Partion 2 is used for the Zpool and should already have these datasets:

Zpool Arrangement:
  NIXROOT/root
  NIXROOT/home
  NIXROOT/nix
  NIXROOT/reserved

"
DESTROY=$(gum choose "DESTROY" "KEEP")
if [ "$DESTROY" == "DESTROY" ]; then

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

if beginswith "/dev/nvme" "$TARGET_DEVICE"; then
  FULL_TARGET_DEVICE="${TARGET_DEVICE}p"
else
  FULL_TARGET_DEVICE="${TARGET_DEVICE}"
fi

sgdisk -n 0:0:+10G -t 0:ef00 -c 0:efi "${TARGET_DEVICE}"
mkfs.fat -F 32 "${FULL_TARGET_DEVICE}"1
fatlabel "${FULL_TARGET_DEVICE}"1 NIXBOOT

# If we are installing from flake then the 
# UUID of the boot disk is hard coded in out configs
# So we need to go and fetch the config, parse out the UUID
# then manually assign it to boot after making the partition

if [ "$FLAKE" == "YES" ]; then
  BOOTUUID=$(curl -s https://github.com/timlinux/nix-config/blob/flakes/hosts/valley.nix | grep -o "by-uuid/[A-Z0-9-]*" | grep -o "[A-Z0-9-]*" | tail -1)
  # See https://superuser.com/a/1294893
  printf "\x${BOOTUUID:7:2}\x${BOOTUUID:5:2}\x${BOOTUUID:2:2}\x${BOOTUUID:0:2}" \
    | dd bs=1 seek=67 count=4 conv=notrunc of="${FULL_TARGET_DEVICE}"1
fi

# Create a partition for / using the remaining space
sgdisk -n 2:0:0 -t 0:8300 -c 0:NIXROOT "${TARGET_DEVICE}" 

gum style "Do you want to encrypt your disk? Typically you should only say no here if you plan to restart the host remotely / without user interaction."
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
      NIXROOT "${FULL_TARGET_DEVICE}"2
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
      NIXROOT "${FULL_TARGET_DEVICE}"2
fi
  # legacy mount points do not get auto mounted at boot
  # rather they must be mounted using fstab
  zfs create -o mountpoint=legacy NIXROOT/root
  zfs create -o mountpoint=legacy NIXROOT/home
  zfs create -o mountpoint=legacy NIXROOT/nix
  # reserved to cope with running out of disk space
  zfs create -o refreservation=1G -o mountpoint=none NIXROOT/reserved

fi

# Check if filesystem is mounted
if mountpoint -q /mnt; then
    echo "The filesystem at /mnt is mounted."
  gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Mounted' 'It appears the ZFS datasets are already mounted.'
else
gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Mounting' 'Mounting the partitions and ZFS datasets:

/mnt/boot
NIXROOT/root /mnt
NIXROOT/home /mnt/home
NIXROOT/nix  /mnt/nix
'
  mount -t zfs NIXROOT/root /mnt
  mkdir /mnt/boot
  mkdir /mnt/home
  mkdir /mnt/nix

  mount "${FULL_TARGET_DEVICE}"1 /mnt/boot
  mount -t zfs NIXROOT/home /mnt/home
  mount -t zfs NIXROOT/nix /mnt/nix
fi


gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Mounts' $(sudo zfs list;sudo mount | grep NIXROOT;sudo mount | grep boot)

nixos-generate-config --force --root /mnt

if [ "$FLAKE" == "YES" ]; then
  git clone https://github.com/timlinux/nix-config.git
  cd nix-config
  cd flakes
  git checkout flakes
  cd ..
  cd ..
  mv /mnt/etc/nixos /mnt/etc/nixos_org
  mv nix-config /mnt/etc/nixos
  gum style "
  Partitioning is complete. If you do not have a host entry for this host
  already configured, you need to add it to the hosts folder
  and the flake.nix file. Then (or if you already have the flake setup) run:

  sudo nixos-install --option eval-cache false --flake /mnt/etc/nixos#${HOSTNAME}
"
  # We are done here....
  exit
fi

##
## Remaining steps are of if you are not using flake based install
##


echo "Are you installing in a VM?"
VM=$(gum choose "YES" "NO")
if [ "$VM" == "YES" ]; then
  VMCONFIG=""
else
  VMCONFIG="#"
fi

if [ "$ENCRYPT" == "YES" ]; then
  ENCRYPT="true"
else
  ENCRYPT="false"
fi

MACHINEID=$(head -c 8 /etc/machine-id)
echo "--"
set +e
read -d '\n' REPLACEMENT << EndOfText
  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid 
  # for notes on how I set up zfs 
  services.zfs.autoScrub.enable = true; 
  boot.loader.grub.enable = true; 
  boot.loader.grub.devices = ["nodev"]; 
  # Bios will then look for an EFI device
  boot.loader.grub.efiInstallAsRemovable = true; 
  boot.loader.grub.efiSupport = true; 
  boot.loader.grub.useOSProber = true; 
  boot.supportedFilesystems = ["zfs"]; 
  boot.zfs.requestEncryptionCredentials = ${ENCRYPT}; 
  ${VMCONFIG}boot.zfs.devNodes = "/dev/disk/by-path"; 
  networking.hostName = "${HOSTNAME}"; # Define your hostname. 
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId 
  # Generate using this: 
  # head -c 8 /etc/machine-id 
  networking.hostId = "${MACHINEID}"; # needed for zfs
EndOfText
echo "--"

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Adding this to configuration.nix' "${REPLACEMENT}"

# It can be either of these so we check for both
rpl " boot.loader.grub.enable = true;" "${REPLACEMENT}" /mnt/etc/nixos/configuration.nix
rpl " boot.loader.systemd-boot.enable = true;" "${REPLACEMENT}" /mnt/etc/nixos/configuration.nix
# This needs to be disabled as it collides with boot.loader.grub.efiInstallAsRemovable
rpl "boot.loader.efi.canTouchEfiVariables = true;" "#boot.loader.efi.canTouchEfiVariables = true;" /mnt/etc/nixos/configuration.nix


# TODO: Investigate why nixos-generate-config puts the wrong blk uuid in hardware config
HWBLKID=$(cat /mnt/etc/nixos/hardware-configuration.nix | grep by-uuid | grep -o "[A-Z0-9-]*\"" | tail -1 | sed "s/\"//g")
ACTUALBLKID=$(blkid | grep NIXBOOT | grep -o "UUID=\"[A-Z0-9-]*\"" | sed "s/UUID=\"//" | sed "s/\"//")
rpl "${HWBLKID}" "${ACTUALBLKID}" /mnt/etc/nixos/hardware_configuration.nix

gum style "
Partitioning is complete.
To complete the configuration, run:

sudo nixos-install 
reboot
"

