{
  config,
  pkgs,
  ...
}: let
  tuxedo = import (builtins.fetchTarball "https://github.com/blitz/tuxedo-nixos/archive/master.tar.gz");
in {
  imports = [
    tuxedo.module
  ];
  hardware.tuxedo-control-center.enable = true;
  hardware.tuxedo-keyboard.enable = true; # enabled you to control rgb in tuxedo control center
}
