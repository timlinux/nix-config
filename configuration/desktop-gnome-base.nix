{
  config,
  pkgs,
  ...
}: {
  # Base for gnome - see x11 and wayland configs too
  imports = [
    ./base.nix
    ../modules/display-server.nix
    ../modules/bluetooth.nix
    ../modules/sound.nix
    ../modules/gnome-desktop-gdm.nix
  ];
}
