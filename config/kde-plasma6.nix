# Install kde plasma - currently you need to be on unstable to do it
# See https://discourse.nixos.org/t/enable-plasma-6/40541
{ config, pkgs, ... }:
{
    services.xserver.desktopManager.plasma6.enable = true;
    services.xserver.displayManager.sddm.wayland.enable = true;
    environment.systemPackages = with pkgs; [
    ];
}

