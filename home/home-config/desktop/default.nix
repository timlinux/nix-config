{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./gtk
    ./qt
    ./keybindings
    ./xdg
  ];
}
