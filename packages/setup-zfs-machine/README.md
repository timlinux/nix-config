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

You may want to set up the machine from your existing host. 
The nixos installer includes an ssh server that you
can log in to. First you need to put your ssh keys
onto the host that you are doing the install on:

```
mkdir ~/.ssh; curl https://github.com/timlinux.keys > ~/.ssh/authorized_keys
ip add | grep inet
```

Then from your existing machine ssh to the install host (replace the IP
address as appropriate):

```
ssh nixos@192.169.0.2
```


