{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    svg-repo = makeDesktopItem {
      name = "SVG Repo";
      desktopName = "SVG Repo";
      genericName = "SVG Repo";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://www.svgrepo.com/"'';
      icon = "nix";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "Graphics"];
      mimeTypes = ["x-scheme-handler/teams"];
      # Needed for the gnome panel icon to be correct
      # and not to stack with other chrome apps
      # You can find out the value to use by running
      # xprop and then clicking on the app window
      # Then set the value below to whatever WM_CLASS(STRING) is
      startupWMClass = "mail.google.com";
    };
  in [svg-repo];
}
