# ZFS Setup

## Installer Script

This script will scrub and set up from scratch your entire machine, using
NixOS and ZFS. Ir provides the following options:

* encrypting your disk
* a flakes based install (machine profile needs to exist in this repo)
* a generic install but with ZFS
* support for above, but  in a VM 

### Running as a remote flake

!!! Note this is not working yet !!!

This flake will prepare the partition scheme on a disk using ZFS and then
install nixos onto the disk.

```
sudo nix run github:timlinux/flakes/flake#setup-zfs-machine
```

### Running locally

```
nix-shell -p gum rpl wget
wget https://raw.githubusercontent.com/timlinux/nix-config/flakes/packages/setup-zfs-machine/setup-host-with-zfs.sh 
chmod +x setup-host-with-zfs.sh
sudo ./setup-host-with-zfs.sh
```

### Running remotely

You may want to debug up the machine remotely from your 
existing host. The nixos installer includes an ssh server 
that you can log in to. First you need to put your ssh keys
onto the host that you are doing the install on:

```
mkdir ~/.ssh; curl https://github.com/timlinux.keys > ~/.ssh/authorized_keys
ip add | grep inet
```

Then from your existing machine ssh to the install host (replace the IP
address as appropriate):

```
ssh -o StrictHostKeyChecking=no nixos@192.169.0.2
```

Now follow the installation steps described above.

## Rescue Script

This script is intended to help you establish a rescue environment
for your ZFS based NixOS install. It will mount your ZFS pool, 
decrypting it if needed.

debug-host-with-zfs.sh

### Running locally

```
nix-shell -p gum rpl wget
wget https://raw.githubusercontent.com/timlinux/nix-config/flakes/packages/setup-zfs-machine/debug-host-with-zfs.sh 
chmod +x debug-host-with-zfs.sh
sudo ./debug-host-with-zfs.sh
```

You may want to debug up the machine remotely from your 
existing host. The nixos installer includes an ssh server 
that you can log in to. First you need to put your ssh keys
onto the host that you are doing the install on:

```
mkdir ~/.ssh; curl https://github.com/timlinux.keys > ~/.ssh/authorized_keys
ip add | grep inet
```

Then from your existing machine ssh to the install host (replace the IP
address as appropriate):

```
ssh -o StrictHostKeyChecking=no nixos@192.169.0.2
```

Now follow the debugging steps described above.
