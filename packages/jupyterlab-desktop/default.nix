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
    icon = "${toString ./jupyterlab-desktop.png}";
  };
micromambaInitRun = pkgs.writeText "micromamba-init-run.sh" (builtins.readFile ../micromamba-shell/micromamba-init-run.sh);
micromambaInitProfile = pkgs.writeText "micromamba-init-profile.sh" (builtins.readFile ../micromamba-shell/micromamba-init-profile.sh);
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
    
    CONDA_ENV_NAME="default-jupyterlab-env"

    # Source micromamba initialization script
    source ${micromambaInitProfile}

    # Configure an exclusive conda set up
    micromamba config append channels conda-forge
    micromamba config append channels nodefaults
    micromamba config set channel_priority strict

    # Create the required environment:
    if ! test -d $MAMBA_ROOT_PREFIX/envs/$CONDA_ENV_NAME; then
        micromamba create --yes -n $CONDA_ENV_NAME python jupyterlab
    fi

    # Update micromamba environment
    # micromamba run --prefix $MAMBA_ROOT_PREFIX/envs/$CONDA_ENV_NAME micromamba update --all -y
        
    set +e

    '';
  extraInstallCommands = ''
    mkdir -p "$out/share/applications"
    cp "${desktopItem}/share/applications/"* $out/share/applications
  '';

  runScript = ''
  # Source the micromamba initialization before running the app
  source ${micromambaInitRun}
  ${jupyterlab-desktop-raw}/bin/jupyterlab-desktop
  '';
}