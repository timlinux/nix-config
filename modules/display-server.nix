{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #hardware.opengl.enable = true;
  environment.systemPackages = with pkgs; [
   xorg.xkill
   # Wayland clipboard
   wl-clipboard
  ];

}
