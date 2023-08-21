{ lib
, mkDerivation
, fetchFromGitHub
, cmake
, ninja
, flex
, bison
, proj
, gdal
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

in mkDerivation rec {
  version = "3.32.1";
  pname = "qgis-nopython-unwrapped";

  src = fetchFromGitHub {
    owner = "qgis";
    repo = "QGIS";
    rev = "final-${lib.replaceStrings [ "." ] [ "_" ] version}";
    hash = "sha256-VNC32ayKN3kiOJMAUPCy5j0wqltSLHjiKIeneFOJqH4=";
  };

  passthru = {
  };

  buildInputs = [
    openssl
    proj
    gdal
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
    ++ lib.optional withWebKit qtwebkit;

  nativeBuildInputs = [ makeWrapper wrapQtAppsHook cmake flex bison ninja ];

  patches = [
  ];

  cmakeFlags = [
    "-DWITH_3D=True"
    "-DWITH_PDAL=TRUE"
    "-DENABLE_TESTS=False"
    "-DWITH_SERVER=False"
    "-DWITH_BINDINGS=False"
  ] ++ lib.optional (!withWebKit) "-DWITH_QTWEBKIT=OFF"
    ++ lib.optional withGrass (let
        gmajor = lib.versions.major grass.version;
        gminor = lib.versions.minor grass.version;
      in "-DGRASS_PREFIX${gmajor}=${grass}/grass${gmajor}${gminor}"
    );

  dontWrapQtApps = true; # wrapper params passed below

  postFixup = lib.optionalString withGrass ''
    # grass has to be available on the command line even though we baked in
    # the path at build time using GRASS_PREFIX.
    # using wrapGAppsHook also prevents file dialogs from crashing the program
    # on non-NixOS
    wrapProgram $out/bin/qgis \
      "''${qtWrapperArgs[@]}" \
      --prefix PATH : ${lib.makeBinPath [ grass ]}
    ln -s qgis $out/bin/qgis-nopython
  '';

  meta = with lib; {
    description = "A Free and Open Source Geographic Information System";
    homepage = "https://www.qgis.org";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; teams.geospatial.members ++ [ lsix ];
    platforms = with platforms; linux;
  };
}
