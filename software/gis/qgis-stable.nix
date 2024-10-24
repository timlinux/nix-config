{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Override the qgis package
    (qgis.overrideAttrs (oldAttrs: rec {
      # Add debugging flags
      NIX_CFLAGS_COMPILE = "${oldAttrs.NIX_CFLAGS_COMPILE or ""} -g";
      dontStrip = true;  # Prevent stripping debug symbols

      # Set extra Python packages for QGIS
      extraPythonPackages = with pkgs.python3Packages; [
        numpy
        requests
        future
        matplotlib
        pandas
        geopandas
        plotly
        #pyqt5_with_qtwebkit
        pyqtgraph
        rasterio
        sqlalchemy
        pyqtwebengine
      ];
    }))
    
    # Additional system packages
    grass  # GRASS GIS package
    saga   # SAGA GIS package
  ];

  # Optional: Enable system-wide debug symbols if you need them globally
  nixpkgs.config = {
    debugInfo = true;
  };
}

