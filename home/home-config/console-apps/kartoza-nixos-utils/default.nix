{
  config,
  pkgs,
  ...
}: let
  appName = "Kartoza Utils";
  iconName = "kartoza-utils.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."kartoza_utils_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    kartozaUtils = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.kitty.package}/bin/kitty -e nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:timlinux/nix-config
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
      startupWMClass = "kitty";          
    };
  in [kartozaUtils];
}
