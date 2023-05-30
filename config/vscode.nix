{ pkgs, config, ... }:

let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    { config = config.nixpkgs.config; };
in {

  environment.systemPackages = with pkgs; [
    unstable.vscode
  ];
}

