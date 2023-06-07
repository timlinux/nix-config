{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  hardware.opengl.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Set gnome to run on x11 or wayland
  services.xserver.displayManager.gdm.wayland = true; 
  programs.xwayland.enable = true;

}
