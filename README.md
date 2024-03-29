# Tim's Nix Configuration

📒 Note: Like most things in life, and in particular in open source, this work is highly derivative. I tried to credit upstream sources in the various configuration files provided here whenever possible.

## Background

I started using NixOS in April 2023. I like keeping notes and making my work repeatable, so NixOS is a good fit for my brain. This repository accumulates the various things I put onto my computers and is going to be in a state of continuous evolution.

## What this repo provides

This repo provides:

1. The flakes that I use to set up a number of different systems that I manage.
2. Some custom packages that I use.
3. Many modules which may prove useful for setting up things like zfs, OBS, Headscale and many other niceties.

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
