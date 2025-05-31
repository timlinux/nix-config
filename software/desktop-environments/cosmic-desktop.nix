{ config, pkgs, ... }:

{
  services.displayManager.cosmic-greeter.enable;
  services.xserver.desktopManager.cosmic.enable = true;
}
