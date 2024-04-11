# ZFS Setup

This flake will prepare the partition scheme on a disk using ZFS and then
install nixos onto the disk.

```
sudo nix run github:timlinux/flakes/flake#setup-zfs-machine
```
or

```
nix-shell -p gum rpl wget
wget https://raw.githubusercontent.com/timlinux/nix-config/flakes/packages/setup-zfs-machine/setup-host-with-zfs.sh 
chmod +x setup-host-with-zfs.sh
sudo ./setup-host-with-zfs.sh
```
