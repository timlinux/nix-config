{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (qgis.override {
      extraPythonPackages = ps:
        with ps; [
          numpy
          requests
          #debugpy
          future
          matplotlib
          pandas
          geopandas
          plotly
          pyqt5_with_qtwebkit
          pyqtgraph
          rasterio
          sqlalchemy
          pyqtwebengine
        ];
    })
    grass
    saga
  ];
}
