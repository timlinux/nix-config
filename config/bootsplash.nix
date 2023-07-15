
{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../packages) ];

  # Boot splash stuff
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ]; # suppresses console text before the pwd prompt
  #boot.plymouth.logo = "/boot/kartoza-wallpaper.png";
  boot.plymouth = {
     enable = true;
     themePackages = [ pkgs.adi1090x-plymouth ];
     theme = "lone"; # provided in ../packages
     # Or comment out the above two lines and use this:
     # boot.plymouth.theme = "breeze"; # default is bgrt which shows manufacturer logo
  };
 
}
