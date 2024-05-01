{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ../modules/bootsplash.nix
    #../configuration/base.nix
    #../configuration/desktop-gnome-x11.nix
    #../users/guest.nix
    #../users/tim.nix
  ];
}
