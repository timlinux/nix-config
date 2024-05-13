{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Its better to explicitly add individual items
    # from this list than using the default set below
    #./android-sdk.nix
    #./ccache.nix
    #./nodejs.nix
    #./pycharm-community.nix
    #./qtcreator.nix
    #./web-dev.nix
    #./arduino.nix
    #./conda.nix # not working
    ./dir-env.nix
    #./playwright.nix
    ./python.nix
    #./rstudio.nix # Use nix-shell rather - see sawps project for an example
    #./zx-spectrum.nix
  ];
}
