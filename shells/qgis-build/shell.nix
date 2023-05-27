{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "cpp project";
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
    libsForQt5.qtkeychain
    libsForQt5.qwt
    libspatialindex
    libspatialite
    libzip
    libzip
    netcdf
    ninja
    openssl
    openssl
    pcre
    pdal
    pkg-config
    postgresql
    proj
    protobuf
    protobuf 
    qscintilla
    sqlite
    sqlite
    swig
    txt2tags
    zstd
    # Python packages
    libsForQt5.qscintilla
    gdal
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
  ];
  
  shellHook = ''
   # Some bash command and export some env vars.
   export FOO=BAR
   echo "Starting new shell";
  '';
}
