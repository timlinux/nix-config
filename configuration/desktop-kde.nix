{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../modules/display-server.nix
    ../modules/kde-plasma6.nix
  ];
}
