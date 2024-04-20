{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./qgis.nix
    ./keepassxc.nix
    ./vscode.nix
    ./uxplay
  ];
}
