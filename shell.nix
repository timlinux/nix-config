#let
#  #
#  # Note that I am using a specific version from NixOS here because of
#  # https://github.com/NixOS/nixpkgs/issues/267916#issuecomment-1817481744
#  #
#  nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz";
#  #nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/51f732d86fac4693840818ad2aa4781d78be2e89.tar.gz";
#  pkgs = import nixpkgs { config = { }; overlays = [ ]; };
#  pythonPackages = pkgs.python311Packages;
with import <nixpkgs> {}; let
  # For packages pinned to a specific version
  #pinnedHash = "617579a787259b9a6419492eaac670a5f7663917";
  #pinnedPkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/${pinnedHash}.tar.gz") {};
  pinnedPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {};
in
  pkgs.mkShell rec {
    allowUnfree = true;
    buildInputs = [
      vscode
      gum # UX for TUIs
      skate # Distributed key/value store
      mods # AI in your shell
      ntfy-sh # Send notifications to your mobile
      gource # Software version control visualization
      marp-cli # Markdown presentation tool
      pinnedPkgs.glow # terminal markdown viewer
      pinnedPkgs.onefetch
      pinnedPkgs.neofetch
      pinnedPkgs.ipfetch
      pinnedPkgs.cpufetch
      pinnedPkgs.ramfetch
      pinnedPkgs.starfetch
      pinnedPkgs.octofetch
      pinnedPkgs.ntfy-sh
    ];

    # Now we can execute any commands within the virtual environment.
    # This is optional and can be left out to run pip manually.
    shellHook = ''
      echo "Kartoza NixOS"
      echo "_________________________________________________________"
      echo "Command : Description"
      echo "_________________________________________________________"
      echo "🚀 nix run          : Open the management utilities menu"
      echo "👀 nix flake show . : Show all the flake details"
      echo "🔍 nix flake update  : Update the flake"
      echo "🩻 nix flake check   : Check the flake"
      echo "🆚 ./vscode         : Open VSCode ready to work on this flake"
      echo " sudo NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --show-trace --impure --flake . : Update your system"
      echo "_________________________________________________________"
      echo "Tim Sutton, 2024   https://github.com/timlinux/nix-config"
    '';
  }
