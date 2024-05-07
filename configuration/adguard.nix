# See the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../modules/adguard.nix
    ../modules/zfs-no-encryption.nix
  ];
}
