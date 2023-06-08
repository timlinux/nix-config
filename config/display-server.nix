{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #hardware.opengl.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Set gnome to run on x11 or wayland
  # Currently I have issues running wayland like flashing windows etc.
  services.xserver.displayManager.gdm.wayland = false; 
  programs.xwayland.enable = false;

}
