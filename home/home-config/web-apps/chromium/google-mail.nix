{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    google-mail = makeDesktopItem {
      name = "GMail";
      desktopName = "GMail";
      genericName = "GMail";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://mail.google.com"'';
      icon = "GMail";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.htmlOffice
      categories = ["Network" "Office"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [google-mail];
}
