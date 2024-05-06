{
  config,
  pkgs,
  ...
}: let
  siteUrl = "https://mygeocommunity.org";
  appName = "My Geo Community";
  iconName = "kartoza-geocommunity.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."kartoza_mygeocommunity_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    myGeocommunityApp = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="${siteUrl}"'';
      icon = iconPath;
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Science"];
    };
  in [myGeocommunityApp];
}
