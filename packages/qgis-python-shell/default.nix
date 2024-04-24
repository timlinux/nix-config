{pkgs ? import <nixpkgs> {} }:
let
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    xorg.libxcb
    qgis
    qt5.full
    qtcreator
    python38
    python38Packages.pyqt5
    python38Packages.gdal
    python38Packages.ipython
    python38Packages.pandas
    python38Packages.pytest
  ];
  shellHook = ''
  export QT_QPA_PLATFORM=offscreen
  export PYTHONPATH=$PYTHONPATH:`which qgis`/../../share/qgis/python
  '';
}



