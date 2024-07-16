{
  config,
  pkgs,
  ...
}: let
  appName = "QGIS Conda";
  iconName = "qgis-conda.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."qgis-conda" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    qgis-conda = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        nix run --extra-experimental-features nix-command --extra-experimental-features flakes "github:timlinux/nix-config#qgis-conda"
      '';
      icon = iconPath;
      categories = ["Network" "System"];
      # Needed for the gnome panel icon to be correct
      # and not to stack with other chrome apps
      # You can find out the value to use by running
      # xprop and then clicking on the app window
      # Then set the value below to whatever WM_CLASS(STRING) is

      #
      # TODO - this works for browsers, not for kitty
      #
      #startupWMClass = "qgis";          
    };
  in [qgis-conda];
}
