{
  config,
  pkgs,
  ...
}: let
  appName = "QGIS 2.18";
  nixpkgsUrl = "https://github.com/NixOS/nixpkgs/archive/f06d8e0bf4822788f93ed994c4a9e88bda3606c3.tar.gz";

  # Import the pinned nixpkgs
  pinnedPkgs = import (fetchTarball nixpkgsUrl) {};

  # Get QGIS from the pinned nixpkgs
  qgis218 = pinnedPkgs.qgis;

  qgisApp = pkgs.makeDesktopItem {
    name = "qgis-2.18";
    desktopName = appName;
    genericName = "Geographic Information System";
    exec = "${qgis218}/bin/qgis";
    icon = "qgis";
    categories = ["Science" "Geography"];
    comment = "A Geographic Information System";
    startupWMClass = "qgis";
  };
in {
  environment.systemPackages = [
    qgis218
    qgisApp
  ];
}
