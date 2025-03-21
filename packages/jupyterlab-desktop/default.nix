{ pkgs ? import <nixpkgs> {}}:
let 
pname = "jupyterlab-dekstop";    
version = "4.2.5-1";   
jupyterlab-desktop-raw = pkgs.stdenv.mkDerivation rec {    

    inherit pname version;

    src = pkgs.fetchurl {
        url = "https://github.com/jupyterlab/jupyterlab-desktop/releases/download/v${version}/JupyterLab-Setup-Debian-x64.deb";    
        sha256 = "EjzTINDfs3BBqlwYh7OGp2ayJORTzx7Wxe7AYLzpauA=";};    
    nativeBuildInputs = [
        pkgs.dpkg
    ];
    unpackPhase = ''    
        dpkg-deb -x $src $out    
        '';    
    installPhase = ''    
        mkdir -p $out/bin 
        ls  $out/opt/JupyterLab/jupyterlab-desktop
        ln -s $out/opt/JupyterLab/jupyterlab-desktop $out/bin/jupyterlab-desktop
    '';   
};
desktopItem = pkgs.makeDesktopItem {
    name = "jupyterlab-desktop";
    exec = "jupyterlab-desktop";
    desktopName = "Jupyterlab Desktop";
    terminal = false;
    icon = "${jupyterlab-desktop-raw}/usr/share/icons/hicolor/512x512/apps/jupyterlab-desktop.png";
  };
micromamba-setup = pkgs.writeText
  "micromamba-setup"
  ''
  # Set up the required variables
  export MAMBA_ROOT_PREFIX="$HOME/micromamba"
  export MAMBA_EXE="${pkgs.micromamba}/bin/micromamba"
  export CONDA_EXE="${pkgs.micromamba}/bin/micromamba"

  # Use conda as micromamba command
  alias conda='micromamba'

  # Initialize the shell
  eval "$($MAMBA_EXE shell hook --shell=posix --root-prefix=$MAMBA_ROOT_PREFIX)"

  # Configure an exclusive conda set up
  micromamba config append channels conda-forge
  micromamba config append channels nodefaults
  micromamba config set channel_priority strict
  '';
in 
pkgs.buildFHSEnv {
  name = "jupyterlab-desktop";

  targetPkgs = pkgs: [
    jupyterlab-desktop-raw
    pkgs.micromamba
    pkgs.yarn
    pkgs.electron
    pkgs.glib
    pkgs.nss
    pkgs.nspr
    pkgs.atk
    pkgs.cups
    pkgs.dbus
    pkgs.libdrm
    pkgs.gtk3
    pkgs.pango
    pkgs.cairo
    pkgs.xorg.libX11
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.xorg.libXrandr
    pkgs.mesa
    pkgs.expat
    pkgs.xorg.libxcb
    pkgs.libxkbcommon
    pkgs.alsa-lib
    pkgs.udev
];
profile = ''
    set -ex

    # Source micromamba initialization script
    source ${micromamba-setup}

    set +e

    '';
  extraInstallCommands = ''
    mkdir -p "$out/share/applications"
    cp "${desktopItem}/share/applications/"* $out/share/applications
  '';

  runScript = ''
  
  # Source micromamba initialization script
  source ${micromamba-setup}

  # Source the bashrc file.
  source ~/.bashrc

  ## Set up global config
  shopt -s expand_aliases  # Enable alias expansion in scripts
  alias jlab=${jupyterlab-desktop-raw}/bin/jupyterlab-desktop

  # Path to conda
  jlab config set condaPath $HOME/.config/jupyterlab-desktop/jlab_server/bin/conda

  # set checkForUpdatesAutomatically to false
  jlab config set checkForUpdatesAutomatically True
  jlab config set installUpdatesAutomatically True
  jlab config set updateBundledEnvAutomatically True

  # Python environment
  jlab config set pythonEnvsPath $MAMBA_ROOT_PREFIX/envs
  jlab config set  systemPythonPath $HOME/.config/jupyterlab-desktop/jlab_server/bin/python
  
  # set theme to "dark"
  jlab config set theme "dark"
 ju
  jlab "$@"
  '';
}