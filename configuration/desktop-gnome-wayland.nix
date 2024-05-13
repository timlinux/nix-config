{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop-gnome-base.nix
    ../software/desktop-environments/gnome-desktop-wayland.nix
  ];
}
