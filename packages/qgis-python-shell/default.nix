# See https://discourse.nixos.org/t/qgis-python-scripts/17746/2
{pkgs ? import <nixpkgs> {}, python3 }:
let
  py = python3.override {
    packageOverrides = self: super: {
      pyqt5 = super.pyqt5.override {
        withLocation = true;
        withSerialPort = true;
      };
    };
  };
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    xorg.libxcb
    qgis
    qt5.full
    qtcreator
    python3
    py.pyqt5
    python3Packages.gdal
    python3Packages.ipython
    python3Packages.pandas
    python3Packages.pytest
  ];
  shellHook = ''
  export QT_QPA_PLATFORM=offscreen
  export PYTHONPATH=$PYTHONPATH:`which qgis`/../../share/qgis/python
  '';
}



