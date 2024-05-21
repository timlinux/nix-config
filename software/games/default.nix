{
  config,
  lib,
  ...
}: {
  imports = [
    ./games.nix
    ./steam.nix
    ./retroarch.nix
  ];
}
