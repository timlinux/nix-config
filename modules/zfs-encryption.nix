# See the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs,  ... }: 
{
  imports = [
    zfs-no-encryption.nix
  ];
  boot.zfs.requestEncryptionCredentials = true;
}
