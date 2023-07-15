
{ pkgs, ... }:

{
  # Boot splash stuff
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ]; # suppresses console text before the pwd prompt
  #boot.plymouth.logo = "/boot/kartoza-wallpaper.png";
  boot.plymouth.theme = "breeze"; # default is bgrt which shows manufacturer logo
}
