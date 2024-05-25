{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../software/system/locale-pt-en.nix
    ../users/guest.nix
    ../users/tim.nix
  ];
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = ["interface-name"]; # Replace "interface-name" with the actual name of your interface
    };

    wireless = {
      enable = true;
      interfaces = ["interface-name"]; # Replace "interface-name" with the actual name of your interface
    };
  };
}
