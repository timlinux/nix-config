{
  config,
  lib,
  ...
}: {
  imports = [
    ./fetchers.nix
    ./fish.nix
    ./starship.nix
    ./utilities.nix
    ./vim.nix
  ];
}
