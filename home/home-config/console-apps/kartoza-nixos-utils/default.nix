{
  config,
  pkgs,
  ...
}: {
  # Run our Nix flake utils package
  # in a terminal
  home.packages = with pkgs; let
    kartoza-nixos-utils = makeDesktopItem {
      name = "Kartoza NixOS Utils";
      desktopName = "Kartoza NixOS Utils";
      genericName = "Kartoza NixOS Utils";
      exec = ''
        ${config.programs.kitty.package}/bin/kitty
      '';
      terminal = "true";
      icon = "Utils";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "System"];
      mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-nixos-utils];
}
