{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./qgis-unstable.nix
    ./keepassxc-unstable.nix
    ./vscode-unstable.nix
    ./uxplay-unstable.nix
  ];
}
