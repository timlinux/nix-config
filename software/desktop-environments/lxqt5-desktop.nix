{ config, pkgs, ... }:

{
  # Enable the X server.
  services.xserver.enable = true;
  # Enable the Budgie Desktop.
  services.xserver.desktopManager.budgie.enable = true;
  # Enable a display manager (recommended).
  services.xserver.displayManager.lightdm.enable = true;
}
