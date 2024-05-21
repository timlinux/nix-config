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
    ../software/desktop-environments/plasma6-desktop.nix
  ];
}
