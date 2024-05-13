{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop-gnome-base.nix
    ../software/desktop-environments/gnome-desktop-x11.nix
  ];
}
