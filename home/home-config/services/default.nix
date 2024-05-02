{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./syncthing
  ];
}
