# See the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../software/system/adguard.nix
    ../software/system/zfs-no-encryption.nix
  ];
}
