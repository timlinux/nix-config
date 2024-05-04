{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    teams-chromium = makeDesktopItem {
      name = "MyGeoCommunity";
      desktopName = "MyGeoCommunity";
      genericName = "MyGeoCommunity";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://mygeocommunity.org"'';
      icon = "Timesheets";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.htmlOffice
      categories = ["Network" "Science"];
      mimeTypes = ["x-scheme-handler/teams"];
    };
  in [teams-chromium];
}
