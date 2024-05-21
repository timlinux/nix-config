##
## For hints on how to set up python deps with QGIS
## see the top level README.md in this repo
##
{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Unstable defined in flake.nix and overlaid to be available here
  environment.systemPackages = with pkgs; [
    #qgis # Installed from stable
    #unstable.qgis-ltr # Installed from unstable
    unstable.qgis # Installed from unstable
    #python311Packages.pyqt5_with_qtwebkit
    #libsForQt5.qt5.qtwebkit
    #saga
  ];
}
