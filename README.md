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

If you do not already have a hardware-configuration.nix, you need to either:

* Run the standard NixOS installer on your system, setting up your disks etc,
* Run the zfs command line installer provided in this flake which will scrub your disks and reformat them with zfs. This is the recommended way to set up your system for the first time.

Whether you use option 1 or 2 above, I *highly* recommend that you encrypt your system. Both options above provide easy workflows for doing that.

I have written (based on great examples I found online) a handy dandy setup
script that will completely set up new hosts with ZFS, encrytion, flakes and
various other niceties. You can find this script in
[``packages/setup-zfs-machine/``](packages/setup-zfs-machine/) - check the
[README.md](packages/setup-zfs-machine/README.md) there first as it explains
how to fetch the script when installing to a new maching. Each system added to
this repo should be validated in the table below. Currently validation is
manual, unfortunately.

## Adding a new host to this flake

There are a few steps when adding a new host for the first time:

1. Create the host file
2. Create the user file 
3. Add the host to the flake.nix

### The host file

Create a new host file in hosts e.g.

```
touch hosts/waterfall.nix
```
The newly created file should exactly match the hostname. This starting point for this file is the hardware-configuration.nix that a new nix installation would generate (see the previous section for more info). This file will normally be found in ``/etc/nixos/``.

There are a few edits you need to make to this file to provide:

#### A network id for your ZFS pool

See [this link](https://search.nixos.org/options?channel=unstable&show=networking.. hostId&query=networking.hostId). You can generate a unique host id using this:

```
head -c 8 /etc/machine-id
```

And then place the entry in your <hostname>.nix file. e.g.

```
networking.hostId = "d13e0d41"; # needed for zfs
```
  

#### A hostname

This should exactly match the hostname of your system. For example:


```
networking.hostName = "crest"; # Define your hostname.
```
  

#### Additional imports to defined your desktop environment etc.

The scheme of this flake provides three main types of imports:

1. **configurations** - these are meta collections of components to e.g. set up your desktop environment or a suite of applications.
2. **modules** - these are atomic units of functionality you can add to your system. Many of them will be added though your chosen configuration, but you may choose to add specific modules. For example locale, biometrics etc.
3. **users** - This is a list of one or more users that you want to have accounts on your system.

There is no "one size fits all" here, but a good starting point will be to look at other hosts and copy their config. For example, here is my list of imports for my system which has a fingerprint reader (needs to be a linux supported reader), a Portuguese keyboard and zfs with encryption enabled:

```
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-pt-en.nix
    ../modules/biometrics.nix
    ../modules/zfs-encryption.nix
    ../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay
    ../users/tim.nix
  ];
```

See the next section for more details about the user file.

### The user file

This file should be added into the ``users`` folder if needed. Name the file after the user's name e.g. ``tim.nix``. It is probably easiest to just copy one of the existing users and adapt it.

The users file file configures your user name, home-manager modules and your user groups. For the most part, you can simply copy the existing user file and then replace all instances of the old user name with your user name.



### The flake file

You need to copy in a new entry for your host into ``flake.nix`` e.g.

```
      # Tim headless box
      valley = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = system;
        modules = shared-modules ++ [./hosts/valley.nix];
      };
```

Then replace the comment and shared modules to reference the new host you have created.

### Submitting your change

Finally, your edits to the flake need to be upstreamed to our git repo. Follow normal git workflows for doing that. I recommend adding your host to the existing hosts list in the next section so the expected behaviour for that host is clear.

### Applying the flake to your system

Simply call the script provided in the root of this flake directory to then apply the changes to your system:

```
sudo ./update-system.sh
```

Applying the flake may take some time depending on your internet connection and whether it needs to compile stuff.

Once the installation completes, reboot and you should be experiencing a nice Kartoza branded experience all the way through the boot up and log in process.

If you experience any issues, remember that you can always select a previous generation at the initial start of your system and then boot into your old environment.

## Existing hosts 

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
