{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    google-meet = makeDesktopItem {
      name = "Google Meet";
      desktopName = "Google Meet";
      genericName = "Google Meet";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://meet.google.com"'';
      icon = "Google Meet";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.htmlOffice
      categories = ["Network" "Office"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [google-meet];
}
