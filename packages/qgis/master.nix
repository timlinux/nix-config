{
  lib,
  makeWrapper,
  symlinkJoin,
  extraPythonPackages ? (ps: []),
  libsForQt5,
}:
with lib; let
  qgis-master = libsForQt5.callPackage ./unwrapped-master.nix {};
in
  symlinkJoin rec {
    inherit (qgis-master) version;
    name = "qgis-${version}";

    paths = [qgis-master];

    nativeBuildInputs = [
      makeWrapper
      qgis-master.py.pkgs.wrapPython
    ];

    # extend to add to the python environment of QGIS without rebuilding QGIS application.
    pythonInputs = qgis-master.pythonBuildInputs ++ (extraPythonPackages qgis-master.py.pkgs);

    postBuild = ''
      # unpackPhase

      buildPythonPath "$pythonInputs"

      wrapProgram $out/bin/qgis \
        --prefix PATH : $program_PATH \
        --set PYTHONPATH $program_PYTHONPATH
    '';

    passthru = {
      unwrapped = qgis-master;
      tests.qgis = nixosTests.qgis;
    };

    inherit (qgis-master) meta;
  }
