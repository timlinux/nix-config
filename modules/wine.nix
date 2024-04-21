{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # native wayland support (unstable)
    wineWowPackages.waylandFull
    # winetricks (all versions)
    winetricks
    bottles
  ];
}


