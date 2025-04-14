{
  config,
  pkgs,
  geospatial,
  system,
  ...
}: {
  environment.systemPackages = [
    (geospatial.packages.${system}.qgis.override {
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
        # ps.pyqt5_with_qtwebkit
        ps.pyqtgraph
        ps.rasterio
        ps.sqlalchemy
      ];
    })
  ];
}
