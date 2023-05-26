{ pkgs, ... }:

{

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    bison
    cmakeWithGui
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
  ];
}

