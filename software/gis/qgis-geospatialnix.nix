{
  config,
  pkgs,
  pkgsWithoutQgis,
  qgisWithExtras,
  ...
}: {
  environment.systemPackages = with pkgsWithoutQgis; [
    qgisWithExtras
  ];
}
