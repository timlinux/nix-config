{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    nix-search = makeDesktopItem {
      name = "Nix Packages";
      desktopName = "Nix Packages";
      genericName = "Nix Packages";
      exec = ''
        ${config.programs.chromium.package}/bin/chromium --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --app="https://search.nixos.org"'';
      icon = "nix";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "System"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [nix-search];
}
