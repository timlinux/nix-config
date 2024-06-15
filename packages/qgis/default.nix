{
  lib,
  makeWrapper,
  symlinkJoin,
  extraPythonPackages ? (ps: []),
  libsForQt5,
}:
with lib; let
  qgis-latest = libsForQt5.callPackage ./unwrapped.nix {
    withGrass = true;
    withWebKit = true;
  };
in
  symlinkJoin rec {
    inherit (qgis-latest) version;
    name = "qgis-${version}";

    paths = [qgis-latest];

    nativeBuildInputs = [
      makeWrapper
      qgis-latest.py.pkgs.wrapPython
    ];

    # extend to add to the python environment of QGIS without rebuilding QGIS application.
    pythonInputs = qgis-latest.pythonBuildInputs ++ (extraPythonPackages qgis-latest.py.pkgs);

    postBuild = ''
      # unpackPhase

      buildPythonPath "$pythonInputs"

      wrapProgram $out/bin/qgis \
        --prefix PATH : $program_PATH \
        --set PYTHONPATH $program_PYTHONPATH
    '';

    passthru = {
      unwrapped = qgis-latest;
      tests.qgis = nixosTests.qgis;
    };

    inherit (qgis-latest) meta;
  }
