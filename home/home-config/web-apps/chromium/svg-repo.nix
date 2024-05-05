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
    };
  in [nix-search];
}
