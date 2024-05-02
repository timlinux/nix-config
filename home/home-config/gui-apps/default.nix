{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./kitty
    ./whatsapp
  ];
}
