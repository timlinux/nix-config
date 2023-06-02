{ pkgs ? import <nixpkgs> {} }:

let 

  fooScript = pkgs.writeScriptBin "build.sh" ''
    #!/bin/sh
    echo $FOO
  '';

  py = pkgs.python3.override {
    packageOverrides = self: super: {
      pyqt5 = super.pyqt5.override {
        withLocation = true;
      };
    };
  };

  qgisPythonDeps = with pkgs; [
    python310Packages.qscintilla
    python310Packages.jinja2
    python310Packages.numpy
    python310Packages.psycopg2
    python310Packages.chardet
    python310Packages.python-dateutil
    python310Packages.pyyaml
    python310Packages.pytz
    python310Packages.requests
    python310Packages.urllib3
    python310Packages.pygments
    python310Packages.pyqt-builder
    python310Packages.sip
    python310Packages.setuptools
    python310Packages.owslib
    python310Packages.six
    python310Packages.pyqt5
    python310Packages.pyqt5_with_qtwebkit
    #qscintilla-qt5
  ];
  qgisPythonEnv = pkgs.python3.withPackages qgisPythonDeps;
#in qgisPythonEnv.env
in

  pkgs.mkShell {
    name = "QGIS Development";
    buildInputs = with pkgs; [
      bison
      clang-tools
      cmake
      cmakeCurses
      exiv2
      expat
      fcgi
      flex
      gdal
      geos
      grass
      gsl
      hdf5
      libsForQt5.qca-qt5
      libsForQt5.qt5.qt3d
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtlocation
      libsForQt5.qt5.qtmultimedia
      libsForQt5.qt5.qtsensors
      libsForQt5.qt5.qtserialport
      libsForQt5.qt5.qtxmlpatterns
      libsForQt5.qt5.qtwebkit
      #libsForQt5.qscintilla
      libsForQt5.qtkeychain
      libsForQt5.qwt
      libspatialindex
      libspatialite
      libzip
      netcdf
      ninja
      openssl
      pcre
      pdal
      pkg-config
      postgresql
      proj
      protobuf
      qscintilla
      sqlite
      swig
      txt2tags
      zstd
      #(python3.withPackages qgisPythonDeps)
    ] ++ qgisPythonDeps;

  #nativeBuildInputs = [ makeWrapper wrapGAppsHook cmake flex bison ninja ];

  patches = [
    (substituteAll {
      src = ./set-pyqt-package-dirs.patch;
      pyQt5PackageDir = "${py.pkgs.pyqt5}/${py.pkgs.python.sitePackages}";
      qsciPackageDir = "${py.pkgs.qscintilla-qt5}/${py.pkgs.python.sitePackages}";
    })
  ];

  shellHook = ''
   # Some bash command and export some env vars.
   export FOO=BAR
   echo "Starting new shell";
  '';
}
