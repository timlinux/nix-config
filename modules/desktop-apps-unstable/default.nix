{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./keepassxc-unstable.nix
    ./vscode-unstable.nix
    ./uxplay-unstable.nix
  ];
}
