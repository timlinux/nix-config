{ lib
, fetchFromGitHub
, makeWrapper
, mkDerivation
, substituteAll
, wrapGAppsHook
, wrapQtAppsHook

, withGrass ? true
, withWebKit ? false

, bison
, cmake
, exiv2
, fcgi
, flex
, geos
, grass
, gsl
, hdf5
, libspatialindex
, libspatialite
, libzip
, netcdf
, ninja
, openssl
, pdal
, postgresql
, proj
, protobuf
, python3
, qca-qt5
, qscintilla
, qt3d
, qtbase
, qtkeychain
, qtlocation
, qtmultimedia
, qtsensors
, qtserialport
, qtwebkit
, qtxmlpatterns
, qwt
, saga
, sqlite
, txt2tags
, zstd
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
    chardet
    gdal
    future
    jinja2
    numpy
    owslib
    pandas
    plotly
    psycopg2
    pygments
    pyqt-builder
    pyqt5
    python-dateutil
    pytz
    pyyaml
    qscintilla-qt5
    requests
    setuptools
    sip
    six
    urllib3
    pyqt5_with_qtwebkit # Added by Tim for InaSAFE
    pyqtgraph # Added by Tim for QGIS Animation workbench (should probably be standard)
    sqlalchemy # Added by Tim for QGIS Animation workbench
  ];
in mkDerivation rec {
  version = "3.32.3";
  pname = "qgis-unwrapped";

  src = fetchFromGitHub {
    owner = "qgis";
    repo = "QGIS";
    rev = "final-${lib.replaceStrings [ "." ] [ "_" ] version}";
    hash = "sha256-ge5ne22sDLKbrJk2vYQxpu3iRXSoOk9924c/RdtD3Nc=";
    #hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  passthru = {
    inherit pythonBuildInputs;
    inherit py;
  };

  nativeBuildInputs = [
    makeWrapper
    wrapGAppsHook
    wrapQtAppsHook

    cmake
    flex
    bison
    ninja
  ];

  buildInputs = [
    exiv2
    fcgi
    geos
    gsl
    hdf5
    libspatialindex
    libspatialite
    libzip
    netcdf
    openssl
    pdal
    postgresql
    proj
    protobuf
    qca-qt5
    qscintilla
    qt3d
    qtbase
    qtkeychain
    qtlocation
    qtmultimedia
    qtsensors
    qtserialport
    qtxmlpatterns
    qwt
    qtwebkit
    saga # Probably not needed for build
    sqlite
    txt2tags
    zstd
  ] ++ lib.optional withGrass grass
    ++ pythonBuildInputs;

  patches = [
    (substituteAll {
      src = ./set-pyqt-package-dirs.patch;
      pyQt5PackageDir = "${py.pkgs.pyqt5}/${py.pkgs.python.sitePackages}";
      qsciPackageDir = "${py.pkgs.qscintilla-qt5}/${py.pkgs.python.sitePackages}";
    })
    ./exiv2-0.28.patch
  ];

  # Add path to Qt platform plugins
  # (offscreen is needed by "${APIS_SRC_DIR}/generate_console_pap.py")
  preBuild = ''
    export QT_QPA_PLATFORM_PLUGIN_PATH=${qtbase.bin}/lib/qt-${qtbase.version}/plugins/platforms
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DWITH_3D=True"
    "-DWITH_PDAL=TRUE"
    "-DENABLE_TESTS=FALSE"
    "-DWITH_SERVER=FALSE"
    "-DWITH_QTWEBKIT=TRUE"]
    ++ lib.optional withGrass (let
        gmajor = lib.versions.major grass.version;
        gminor = lib.versions.minor grass.version;
      in "-DGRASS_PREFIX${gmajor}=${grass}/grass${gmajor}${gminor}"
    );

  qtWrapperArgs = [
    "--set QT_QPA_PLATFORM_PLUGIN_PATH ${qtbase.bin}/lib/qt-${qtbase.version}/plugins/platforms"
  ];

  dontWrapGApps = true; # wrapper params passed below

  postFixup = lib.optionalString withGrass ''
    # GRASS has to be availble on the command line even though we baked in
    # the path at build time using GRASS_PREFIX.
    # Using wrapGAppsHook also prevents file dialogs from crashing the program
    # on non-NixOS.
    wrapProgram $out/bin/qgis \
      "''${gappsWrapperArgs[@]}" \
      --prefix PATH : ${lib.makeBinPath [ grass ]}
  '';

  meta = {
    description = "A Free and Open Source Geographic Information System";
    homepage = "https://www.qgis.org";
    license = lib.licenses.gpl2Plus;
    platforms = with lib.platforms; linux;
    maintainers = with lib.maintainers; [ lsix sikmir willcohen ];
  };
}
