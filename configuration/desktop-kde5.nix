{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../modules/display-server.nix
    ../modules/bluetooth.nix
    ../modules/sound.nix
    ../modules/plasma-desktop.nix
  ];
}
