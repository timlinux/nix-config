{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../packages) ];
  environment.systemPackages = with pkgs; [
    # taken from packages folder
    #qgis
    # taken from packages folder
    #qgis-ltr
    # taken from packages folder
    qgis-master
    saga
  ];
}

