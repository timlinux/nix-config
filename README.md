# Tim's Nix Configuration

```
                      ///             
                  ///////////         
                 ////     ////        
                 ///       ///        
                 ////      *//        
              ,,, //// //////////     
           ,,,,,   ////        /////  
          ,,,         ,,,,        /// 
          ,,,       ,,,,  /      //// 
           ,,,,,,,,,,,   ///////////  
              ,,,,           ///* 

██╗  ██╗ █████╗ ██████╗ ████████╗ ██████╗ ███████╗ █████╗             
██║ ██╔╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗╚══███╔╝██╔══██╗            
█████╔╝ ███████║██████╔╝   ██║   ██║   ██║  ███╔╝ ███████║            
██╔═██╗ ██╔══██║██╔══██╗   ██║   ██║   ██║ ███╔╝  ██╔══██║            
██║  ██╗██║  ██║██║  ██║   ██║   ╚██████╔╝███████╗██║  ██║            
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝            
                                                                      
███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗ 
████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

```

📒 Note: Like most things in life, and in particular in open source, this work
is highly derivative. I tried to credit upstream sources in the various
configuration files provided here whenever possible.

## Background

I started using NixOS in April 2023. I like keeping notes and making my work
repeatable, so NixOS is a good fit for my brain. This repository accumulates
the various things I put onto my computers and is going to be in a state of
continuous evolution. I am co-founder of a company called
[Kartoza](https://kartoza.com). We use NixOS on our linux workstations and 
this repository provides a canonical source of those configurations.

## What this repo provides

This repo provides:

1. The flakes that I use to set up a number of different systems that I manage.
2. Some custom packages that I use.
3. Many modules which may prove useful for setting up things like zfs, OBS, Headscale and many other niceties.

## Setting up a new system

I have written (based on great examples I found online) a handy dandy setup
script that will completely set up new hosts with ZFS, encrytion, flakes and
various other niceties. You can find this script in
[``packages/setup-zfs-machine/``](packages/setup-zfs-machine/) - check the
[README.md](packages/setup-zfs-machine/README.md) there first as it explains
how to fetch the script when installing to a new maching. Each system added to
this repo should be validated in the table below. Currently validation is
manual, unfortunately.

## Hosts 

### Test

The test environment for NixOS that can be used to 
validate configuration changes etc. The text environment
is created using the `nixos-rebuild build-vm` command and
can be created by running `./vm-test-environment.sh` in
the root of this repo.

You can log in to this test environment using:

User: guest
Pass: guest

| Host | Encryption | Flake | Works | Notes |
|---|---|---|---|----|
| valley | 🟢 | 🔴 | ⛔️ | Encryption not supported, no profile for this.|
| valley | 🔴 | 🔴 | ⛔️ | Encryption not supported, no profile for this. |
| valley | 🟢 | 🟢 | ⛔️ | Encryption not supported, no profile for this.|
| valley | 🔴 | 🟢 | ✔️| | ❤️  Generic install created for testing. |


### Valley 

An i3 Intel NUC that I use as a home server.

| Host | Encryption | Flake | Works | Notes |
|---|---|---|---|----|
| valley | 🟢 | 🔴 | ✔️ | Generic install |
| valley | 🔴 | 🔴 | ✔️ | Generic install |
| valley | 🟢 | 🟢 | ✔️ | ❤️  Production install for home server |
| valley | 🔴 | 🟢 | ⛔️| No profile for this |

### Rock

A VM that you can use to test and experiment with things. To set up the VM,
follow the steps below the table. Unlike the 'test' VM, rock is
intended to be installed on a manually partitioned virtual disk
with ZFS.

|Host | Encryption | Flake | Works| Notes |
|-----|------------|------|------|------| 
|rock| 🟢| 🔴| ✔️| | Generic Install |
|rock| 🔴| 🔴| ✔️| | Generic Install |
|rock| 🟢| 🟢| ✔️ | ❤️  Production install for learning NixOS etc. |
|rock| 🔴| 🟢| ⛔️ | No profile for this |

![Step 1](img/vm-install1.png)
![Step 2](img/vm-install2.png)
![Step 3](img/vm-install3.png)
![Step 4](img/vm-install4.png)
![Step 5](img/vm-install5.png)
![Step 6](img/vm-install6.png)
![Step 7](img/vm-install7.png)
![Step 8](img/vm-install8.png)
![Step 9](img/vm-install9.png)
![Step 10](img/vm-install0.png)
![Step 11](img/vm-install11.png)


## Listing flakes

You can list the flakes like this:

```
nix flake show github:timlinux/nix-config
```

Or if you want to refer to a git branch, add it to the end of the URL e.g. for a branch called 'flakes':

```
nix flake show github:timlinux/nix-config/flakes
```

You will get something like this in the output (most likely changed since I made this screenshot):

![](img/flake-show.png)

## Updating flakes

If the flake has been modified in this repo, you can update it like this:

```
nix flake update github:timlinux/nix-config
```

or for a git branch e.g. 'flakes' branch:

```
nix flake update github:timlinux/nix-config/flakes
```


## Resources

I found some resouces particularly valuable in my learning journey, I will try to assemble them here:

1. 📺️ [Chris McDonough's YouTube Channel](https://www.youtube.com/@ChrisMcDonough) - so many great videos that patiently walk through key activities in setting up different aspects of NixOS.
2. 📝 [Determinate Systems Blog](https://determinate.systems/posts) - many interesting and useful hints and tips to get the most out of NixOS.
3. 🎒 [Zero To Nix](https://zero-to-nix.com/) - nice learning resource for those starting out in NixOS.
