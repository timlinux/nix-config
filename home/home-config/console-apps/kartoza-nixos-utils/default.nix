{
  config,
  pkgs,
  ...
}: {
  home.file."copy_image" = {
    # Specify the source path of the image file
    source = "./kartoza-utils.svg";

    # Specify the target path where you want to copy the image file
    target = "${config.home.homeDirectory}/.local/share/icons/kartoza-utils.svg";

    # Specify whether to overwrite the file if it already exists
    # (true by default)
    #overwrite = true;
  };
  # Run our Nix flake utils package
  # in a terminal
  home.packages = with pkgs; let
    kartoza-nixos-utils = makeDesktopItem {
      name = "Kartoza NixOS Utils";
      desktopName = "Kartoza NixOS Utils";
      genericName = "Kartoza NixOS Utils";
      exec = ''
        ${config.programs.kitty.package}/bin/kitty -e nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:timlinux/nix-config
      '';
      # We launch in kitty rather to disable
      #terminal = true;
      icon = "${config.home.homeDirectory}/.local/share/icons/kartoza-utils.svg";
      # See https://specifications.freedesktop.org/menu-spec/latest/apa.html
      categories = ["Network" "System"];
      #mimeTypes = ["x-scheme-handler/teams"];
    };
  in [kartoza-nixos-utils];
}
