{
  config,
  lib,
  ...
}: {
  imports = [
    ./fetchers.nix
    ./fish.nix
    ./micromamba-shell.nix
    ./starship.nix
    ./utilities.nix
    ./vim.nix
  ];
}
