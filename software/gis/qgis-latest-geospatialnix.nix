{
  config,
  pkgs,
  geospatial,
  system,
  ...
}: let
  appName = "QGIS Latest";

  qgisLatest = geospatial.packages.${system}.qgis.override {
    extraPythonPackages = ps: [
      ps.pyqtwebengine
      ps.jsonschema
      ps.debugpy
      ps.future
      ps.psutil
      ps.numpy
      ps.requests
      ps.matplotlib
      ps.pandas
      ps.geopandas
      ps.plotly
      ps.pyqtgraph
      ps.rasterio
      ps.sqlalchemy
    ];
  };

  qgisLatestApp = pkgs.makeDesktopItem {
    name = "qgis-latest";
    desktopName = appName;
    genericName = "Geographic Information System";
    exec = "${qgisLatest}/bin/qgis";
    icon = "qgis";
    categories = ["Science" "Geography"];
    comment = "A Geographic Information System";
    startupWMClass = "qgis";
  };
in {
  environment.systemPackages = [
    qgisLatest
    qgisLatestApp
  ];
}
