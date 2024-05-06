{
  config,
  pkgs,
  ...
}: let
  siteUrl = "https://search.nixos.org";
  appName = "Nix Package Search";
  iconName = "nix-search.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."nix_search_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    nixSearchApp = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="${siteUrl}"'';
      icon = iconPath;
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Office"];
    };
  in [nixSearchApp];
}
