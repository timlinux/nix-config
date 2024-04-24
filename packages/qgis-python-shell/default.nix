{pkgs ? import <nixpkgs> {} }:
let
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    xorg.libxcb
    qgis
    qt5.full
    qtcreator
    python3
    python3Packages.pyqt5
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



