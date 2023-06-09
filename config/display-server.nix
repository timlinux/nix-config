{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #hardware.opengl.enable = true;
  programs.xwayland.enable = false;

}
