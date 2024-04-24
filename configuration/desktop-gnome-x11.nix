{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop-gnome-base.nix
    ../modules/gnome-desktop-x11.nix
  ];
}
