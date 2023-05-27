{ pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    bison
    cmakeCurses
    clang-tools
    exiv2
    fcgi
    gdal
    geos
    gsl
    expat
    hdf5
    libsForQt5.qca-qt5
    libsForQt5.qt5.qt3d
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtlocation
    libsForQt5.qt5.qtmultimedia
    libsForQt5.qt5.qtsensors
    libsForQt5.qt5.qtserialport
    libsForQt5.qt5.qtxmlpatterns
    libsForQt5.qtkeychain
    libsForQt5.qwt
    libspatialindex
    libspatialite
    libzip
    netcdf
    openssl
    pdal
    postgresql
    proj
    protobuf
    qscintilla
    sqlite
    txt2tags
    zstd
    grass
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
    #(python310Packages.pyqt5.override {
    #  python310Packages.pyqt5 = python310Packages.pyqt5.override {
    #    withLocation = true;
    #  };
    #})
  ];
}

