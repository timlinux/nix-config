{ pkgs ? import <nixpkgs> {}}:
let 
desktopItem = pkgs.makeDesktopItem {
    name = "qgis-conda";
    exec = "qgis-conda";
    desktopName = "QGIS (conda)";
    terminal = false;
    icon = "${toString ./qgis.svg}";
  };
  micromambaInitRun = pkgs.writeText "micromamba-init-run.sh" (builtins.readFile ../micromamba-shell/micromamba-init-run.sh);
  micromambaInitProfile = pkgs.writeText "micromamba-init-profile.sh" (builtins.readFile ../micromamba-shell/micromamba-init-profile.sh);
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
                
        # Source micromamba initialization script
        source ${micromambaInitProfile}

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