{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yubikey-manager-qt # launch using ykman-gui
    yubikey-agent
    yubikey-manager
    yubikey-personalization-gui
  ];
  services.udev.packages = [ 
    pkgs.yubikey-personalization 
    #gnome.gnome-settings-daemon # app tray
  ];
}
