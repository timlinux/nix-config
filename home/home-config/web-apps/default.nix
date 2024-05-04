{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./chromium
    #./firefox #see README in firefox folder to see why it is disabled
  ];
}
