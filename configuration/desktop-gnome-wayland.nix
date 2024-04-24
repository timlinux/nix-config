{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop-gnome-base.nix
    ../modules/gnome-desktop-wayland.nix
  ];
}
