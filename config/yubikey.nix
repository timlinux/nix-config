{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yubikey-manager-qt # launch using ykman-gui
    yubikey-agent
    yubikey-manager
    yubikey-personalization-gui
  ];

  ##
  ## Yubikey PAM support - see https://nixos.wiki/wiki/Yubikey
  ## 
  services.udev.packages = [ 
    pkgs.yubikey-personalization 
    #gnome.gnome-settings-daemon # app tray
  ];

}
