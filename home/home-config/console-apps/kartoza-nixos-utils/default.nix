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
    };
  in [kartozaUtils];
}
