
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
     # See https://github.com/adi1090x/plymouth-themes
     # for a list of other awesome themes
     theme = "lone"; # provided in ../packages
     # Or comment out the above two lines and use this:
     # boot.plymouth.theme = "breeze"; # default is bgrt which shows manufacturer logo
  };
 
}
