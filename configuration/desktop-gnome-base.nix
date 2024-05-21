{
  config,
  pkgs,
  ...
}: {
  # Base for gnome - see x11 and wayland configs too
  imports = [
    ./base.nix
    ../software/desktop-environments/display-server.nix
    ../software/system/bluetooth.nix
    ../software/system/sound.nix
    ../software/desktop-environments/gnome-desktop-gdm.nix
  ];
}
