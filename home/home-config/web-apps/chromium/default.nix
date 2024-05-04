{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./ms-teams.nix
    ./nix-search.nix
  ];
}
