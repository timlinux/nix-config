{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    kartoza-timesheets = makeDesktopItem {
      name = "Kartoza Timesheets";
      desktopName = "Kartoza Timesheets";
      genericName = "Kartoza Timesheets";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://timesheets.kartoza.com"'';
      icon = "Timesheets";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Office"];
      mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-timesheets];
}
