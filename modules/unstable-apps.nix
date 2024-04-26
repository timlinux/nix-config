{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./qgis-unstable.nix
    ./keepassxc.nix
    ./vscode.nix
    ./uxplay.nix
  ];
}
