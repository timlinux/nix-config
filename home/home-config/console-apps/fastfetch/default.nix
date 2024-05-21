{
  config,
  pkgs,
  ...
}: let
  # Variables or actual values to substitute
  iconPath = "${config.home.homeDirectory}/.local/share/icons/kartoza-logo.png";
  #configFilePath = "${config.xdg.configHome}/fastfetch/config.jsonc";
in {
  # You can add more file entries in case you have more configs
  home.file."kartoza-logo" = {
    ###
    ### NOTE: png not supported, use jpg - lost hours of my life
    ###       trying to figure out why the image was not showing up...
    ###
    source = ../../../../resources/kartoza-logo.jpg;
    target = iconPath;
  };
  home.file.".config/fastfetch/config.jsonc".source = pkgs.substituteAll {
    # See https://en.wikipedia.org/wiki/ANSI_escape_code
    # For color codes used in the config file below.
    src = ./fastfetch.jsonc; # Path to the template file
    # Placeholders in jsonc should look like ${iconPath} to be replaced by
    # the actual values specified in the Nix expression.
    iconPath = "${iconPath}"; # Variables to substitute in the file
  };

  # See modules/fetches.nix for other fetchers which do not have home-manager configs defined
  home = {
    packages = with pkgs; [
      fastfetch # Modern Unix system info
      chafa # Image to ASCII converter - needed to display our logo
    ];
  };
}
