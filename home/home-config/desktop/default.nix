{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./gtk
    ./keybindings
    ./xdg
  ];
}
