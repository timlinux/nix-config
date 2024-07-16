{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./kitty
    ./qgis-conda
  ];
}
