{ config, pkgs,  ... }: 
{
  ### Bleeding edge kernel - may run into issues with zfs
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
