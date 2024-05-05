{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    google-calendar = makeDesktopItem {
      name = "Google Calendar";
      desktopName = "Google Calendar";
      genericName = "Google Calendar";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://calendar.google.com"'';
      icon = "Calendar";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.htmlOffice
      categories = ["Network" "Office"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [google-calendar];
}
