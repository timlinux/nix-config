{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../packages) ];
  environment.systemPackages = with pkgs; [
    qgis # taken from packages folder
    qgis-ltr # taken from packages folder
    saga
  ];
}

