{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    kartoza-training = makeDesktopItem {
      name = "Kartoza Training";
      desktopName = "Kartoza Training";
      genericName = "Kartoza Training";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://training.kartoza.com"'';
      icon = "Timesheets";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.htmlOffice
      categories = ["Network" "Education"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-training];
}
