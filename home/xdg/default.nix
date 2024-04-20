{ config, ... }:
let
  browser = "re.sonny.Junction.desktop";
  # spreadsheet = "libreoffice-calc.desktop";
  pdf = "evince.desktop";
in {
  config = {
    xdg = {
      enable = true;

      userDirs = {
        createDirectories = true;
        enable = true;
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        desktop = "${config.home.homeDirectory}/Desktop";
        templates = "${config.home.homeDirectory}/Templates";
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = pdf;
          "text/html" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/unknown" = browser;

          # "application/vnd.oasis.opendocument.spreadsheet" = spreadsheet;
        };
      };
    };
  };
}
