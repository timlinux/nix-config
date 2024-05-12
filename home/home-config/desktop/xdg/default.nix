{config, ...}: let
  browser = "re.sonny.Junction.desktop";
  # spreadsheet = "libreoffice-calc.desktop";
  evince = "org.gnome.Evince.desktop";
  qgis = "org.qgis.qgis.desktop";
in {
  config = {
    xdg = {
      enable = true;
      # See https://github.com/nix-community/home-manager/issues/1213
      configFile."mimeapps.list".force = true;
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
        associations.added = {
          "application/pdf" = evince;
          "image/png" = evince;
          "image/jpg" = evince;
          "image/gif" = evince;
        };
        defaultApplications = {
          "application/pdf" = evince;
          "image/png" = evince;
          "image/jpg" = evince;
          "image/gif" = evince;
          "text/html" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/unknown" = browser;
          "text/plain" = "org.gnome.TextEditor.desktop";
          "application/octet-stream" = qgis;
          "image/tiff" = qgis;
          "application/vnd.sqlite3" = qgis;
        };
      };
    };
  };
}
