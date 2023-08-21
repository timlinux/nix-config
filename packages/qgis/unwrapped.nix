{ lib
, mkDerivation
, fetchFromGitHub
, cmake
, ninja
, flex
, bison
, proj
, geos
, sqlite
, gsl
, qwt
, fcgi
, python3
, libspatialindex
, libspatialite
, postgresql
, txt2tags
, openssl
, libzip
, hdf5
, netcdf
, exiv2
, protobuf
, qtbase
, qtsensors
, qca-qt5
, qtkeychain
, qt3d
, qscintilla
, qtlocation
, qtserialport
, qtxmlpatterns
, withGrass ? true
, grass
, withWebKit ? false
, qtwebkit
, pdal
, zstd
, makeWrapper
, wrapQtAppsHook
, substituteAll
}:

let

  py = python3.override {
    packageOverrides = self: super: {
      pyqt5 = super.pyqt5.override {
        withLocation = true;
      };
    };
  };

  pythonBuildInputs = with py.pkgs; [
    qscintilla-qt5
    gdal
    jinja2
    numpy
    psycopg2
    chardet
    python-dateutil
    pyyaml
    pytz
    requests
    urllib3
    pygments
    pyqt5
    pyqt-builder
    sip
    setuptools
    owslib
    six
  ];
in mkDerivation rec {
  version = "3.32.1";
  pname = "qgis-unwrapped";

  src = fetchFromGitHub {
    owner = "qgis";
    repo = "QGIS";
    rev = "final-${lib.replaceStrings [ "." ] [ "_" ] version}";
    hash = "sha256-VNC32ayKN3kiOJMAUPCy5j0wqltSLHjiKIeneFOJqH4=";
  };

  passthru = {
    inherit pythonBuildInputs;
    inherit py;
  };

  buildInputs = [
    openssl
    proj
    geos
    sqlite
    gsl
    qwt
    exiv2
    protobuf
    fcgi
    libspatialindex
    libspatialite
    postgresql
    txt2tags
    libzip
    hdf5
    netcdf
    qtbase
    qtsensors
    qca-qt5
    qtkeychain
    qscintilla
    qtlocation
    qtserialport
    qtxmlpatterns
    qt3d
    pdal
    zstd
  ] ++ lib.optional withGrass grass
    ++ lib.optional withWebKit qtwebkit
    ++ pythonBuildInputs;

  nativeBuildInputs = [ makeWrapper wrapQtAppsHook cmake flex bison ninja ];

  patches = [
    (substituteAll {
      src = ./set-pyqt-package-dirs.patch;
      pyQt5PackageDir = "${py.pkgs.pyqt5}/${py.pkgs.python.sitePackages}";
      qsciPackageDir = "${py.pkgs.qscintilla-qt5}/${py.pkgs.python.sitePackages}";
    })
    ./fix-qsci.patch
  ];

  #QT_QPA_PLATFORM_PLUGIN_PATH="${qt5.qtbase.bin}/lib/qt-${qt5.qtbase.version}/plugins/platforms";
  QT_QPA_PLATFORM_PLUGIN_PATH="/nix/store/9j0acz9qqp1lygwif5jncpz8hsyfmylw-qtbase-5.15.9-bin/lib/qt-5.15.9/plugins/platforms";

  cmakeFlags = [
    "-DWITH_3D=True"
    "-DWITH_PDAL=TRUE"
    "-DENABLE_TESTS=False"
    "-DWITH_SERVER=False"
    "-DWITH_QSCIAPI=False" # Scintilla API generation currently broken - see https://github.com/NixOS/nixpkgs/issues/248239
  ] ++ lib.optional (!withWebKit) "-DWITH_QTWEBKIT=OFF"
    ++ lib.optional withGrass (let
        gmajor = lib.versions.major grass.version;
        gminor = lib.versions.minor grass.version;
      in "-DGRASS_PREFIX${gmajor}=${grass}/grass${gmajor}${gminor}"
    );

  # This mimics what is happening in PixInsight.sh and adds on top the libudev0-shim, which
  # without PixInsight crashes at startup.
  qtWrapperArgs = [
    #"--prefix LD_LIBRARY_PATH : ${libudev0-shim}/lib"
    #"--set LC_ALL en_US.utf8"
    #"--set AVAHI_COMPAT_NOWARN 1"
    #"--set QT_PLUGIN_PATH $out/opt/PixInsight/bin/lib/qt-plugins"
    "--set QT_QPA_PLATFORM_PLUGIN_PATH $out/lib/qt-plugins/platforms"
    #"--set QT_AUTO_SCREEN_SCALE_FACTOR 0"
    #"--set QT_ENABLE_HIGHDPI_SCALING 0"
    #"--set QT_SCALE_FACTOR 1"
    #"--set QT_LOGGING_RULES '*=false'"
    #"--set QTWEBENGINEPROCESS_PATH $out/opt/PixInsight/bin/libexec/QtWebEngineProcess"
  ];

  dontWrapQtApps = true; # wrapper params passed below

  postFixup = lib.optionalString withGrass ''
    # grass has to be available on the command line even though we baked in
    # the path at build time using GRASS_PREFIX.
    # using wrapGAppsHook also prevents file dialogs from crashing the program
    # on non-NixOS
    wrapProgram $out/bin/qgis \
      "''${qtWrapperArgs[@]}" \
      --prefix PATH : ${lib.makeBinPath [ grass ]}
      ln -s qgis $out/bin/qgis-latest
  '';

  meta = with lib; {
    description = "A Free and Open Source Geographic Information System";
    homepage = "https://www.qgis.org";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; teams.geospatial.members ++ [ lsix ];
    platforms = with platforms; linux;
  };
}
