{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./android-sdk.nix
    ./ccache.nix
    ./default.nix
    ./nodejs.nix
    ./pycharm-community.nix
    ./qtcreator.nix
    #./web-dev.nix
    #./arduino.nix
    #./conda.nix # not working
    ./dir-env.nix
    ./playwright.nix
    ./python.nix
    #./rstudio.nix # Use nix-shell rather - see sawps project for an example
    #./zx-spectrum.nix
  ];
}
