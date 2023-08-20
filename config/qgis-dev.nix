{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../packages) ];
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    qgis-selfbuild # taken from packages folder
  ];
}

