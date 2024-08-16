{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../software/desktop-environments/display-server.nix
    ../software/system/bluetooth.nix
    ../software/system/sound.nix
    ../software/desktop-environments/kde-plasma6.nix
  ];
  networking.networkmanager.enable = true;
}
