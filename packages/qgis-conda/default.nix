{ pkgs ? import <nixpkgs> {}}:
let 
homeDir = builtins.getEnv "HOME";
mambaRoot = "${homeDir}/micromamba";
desktopItem = pkgs.makeDesktopItem {
    name = "qgis-conda";
    exec = "qgis-conda";
    desktopName = "QGIS (conda)";
    terminal = false;
    icon = "${mambaRoot}/envs/qgis-conda-env/share/icons/hicolor/512x512/apps/qgis.png";
  };
in
pkgs.buildFHSEnv {
    name = "qgis-conda";

    targetPkgs = _: [
      pkgs.micromamba
      pkgs.libGL
    ];

    profile = ''
        set -ex
        
        CONDA_ENV_NAME="qgis-conda-env"
                
        # Set up the required variables
        export MAMBA_ROOT_PREFIX="${mambaRoot}"
        export MAMBA_EXE=$(which micromamba)
        export CONDA_EXE=$(which micromamba)

        # Use conda as micromamba command
        alias conda='micromamba'

        # Initialize the shell
        eval "$($MAMBA_EXE shell hook --shell=posix --root-prefix=$MAMBA_ROOT_PREFIX)"

        # Configure an exclusive conda set up
        micromamba config append channels conda-forge
        micromamba config append channels nodefaults
        micromamba config set channel_priority strict
        
        # Create the required environment:
        if ! test -d $MAMBA_ROOT_PREFIX/envs/$CONDA_ENV_NAME; then
            micromamba create --yes -n $CONDA_ENV_NAME qgis libgdal-arrow-parquet
        fi
        
        # Activate the environment.
        micromamba activate $CONDA_ENV_NAME
        
        set +e

    '';

  extraInstallCommands = ''
    mkdir -p "$out/share/applications"
    cp "${desktopItem}/share/applications/"* $out/share/applications
  '';

  runScript = "qgis";

}