{ config, pkgs,  ... }: 
{
  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid
  # for notes on how I set up zfs
  services.zfs.autoScrub.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = ["zfs"];
}
