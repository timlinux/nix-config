##
## For hints on how to set up python deps with QGIS
## see the top level README.md in this repo
##
{pkgs, ...}: {
  nixpkgs.overlays = [(import ../../packages)];
  environment.systemPackages = with pkgs; [
    # taken from packages folder
    qgis
  ];
}
