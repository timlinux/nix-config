{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    kartoza-handbook = makeDesktopItem {
      name = "Kartoza Handbook";
      desktopName = "Kartoza Handbook";
      genericName = "Kartoza Handbook";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://kartoza.github.io/TheKartozaHandbook/"'';
      icon = "nix";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Office"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-handbook];
}
