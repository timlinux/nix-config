##
## For hints on how to set up python deps with QGIS
## see the top level README.md in this repo
##
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qgis # Installed from stable
  ];
}
