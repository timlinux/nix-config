{ lib, makeWrapper, symlinkJoin
, libsForQt5
}:
with lib;
let
  qgis-nopython-unwrapped = libsForQt5.callPackage ./unwrapped-nopython.nix {  };
in symlinkJoin rec {

  inherit (qgis-nopython-unwrapped) version;
  name = "qgis-${version}";

  paths = [ qgis-nopython-unwrapped ];

  nativeBuildInputs = [ makeWrapper ];

  postBuild = ''
    # unpackPhase

    wrapProgram $out/bin/qgis \
      --prefix PATH : $program_PATH 
  '';

  passthru.unwrapped = qgis-nopython-unwrapped;

  inherit (qgis-nopython-unwrapped) meta;
}
