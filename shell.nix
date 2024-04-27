#let
#  #
#  # Note that I am using a specific version from NixOS here because of
#  # https://github.com/NixOS/nixpkgs/issues/267916#issuecomment-1817481744
#  #
#  nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz";
#  #nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/51f732d86fac4693840818ad2aa4781d78be2e89.tar.gz";
#  pkgs = import nixpkgs { config = { }; overlays = [ ]; };
#  pythonPackages = pkgs.python311Packages;

with import <nixpkgs> { };
let
  # For packages pinned to a specific version
  pinnedHash = "617579a787259b9a6419492eaac670a5f7663917";
  pinnedPkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/${pinnedHash}.tar.gz") { };
in pkgs.mkShell rec {
  allowUnfree = true;
  buildInputs = [
    gum # UX for TUIs
    skate # Distributed key/value store
    pinnedPkgs.glow # terminal markdown viewer
    pinnedPkgs.onefetch
    pinnedPkgs.neofetch
    pinnedPkgs.ipfetch
    pinnedPkgs.cpufetch
    pinnedPkgs.ramfetch
    pinnedPkgs.starfetch
    pinnedPkgs.octofetch
  ];

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  shellHook = ''
    onefetch
    ipfetch
    cpufetch
    ramfetch
    starfetch
    octofetch 
  '';


}
