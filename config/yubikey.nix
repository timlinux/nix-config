{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yubikey-manager-qt # launch using ykman-gui
    yubikey-agent
    yubikey-manager
    yubikey-personalization-gui
  ];


}
