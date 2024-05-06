{
  config,
  pkgs,
  ...
}: let
  siteUrl = "https://kartoza.github.io/TheKartozaHandbook/";
  appName = "Kartoza Handbook";
  iconName = "kartoza-handbook.svg";
  iconPath = "${config.home.homeDirectory}/.local/share/icons/${iconName}";
in {
  home.file."kartoza_handbook_image" = {
    source = ./${iconName};
    target = iconPath;
  };
  home.packages = with pkgs; let
    gmailApp = makeDesktopItem {
      name = appName;
      desktopName = appName;
      genericName = appName;
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="${siteUrl}"'';
      icon = iconPath;
      categories = ["Network" "Office"];
    };
  in [myKartozaHandbookApp];
}
