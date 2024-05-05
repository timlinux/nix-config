{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    kartoza-erp = makeDesktopItem {
      name = "Kartoza ERP";
      desktopName = "Kartoza ERP";
      genericName = "Kartoza ERP";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://kartoza.com"'';
      icon = "Timesheets";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Office"];
      mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-erp];
}
