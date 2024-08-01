{
  config,
  lib,
  ...
}: {
  imports = [
    ./gnome-desktop-apps.nix
    ./gui-apps.nix
    ./localsend.nix
    ./obs.nix
    ./scrcpy.nix
    ./iphone.nix
    ./nixos-conf-editor.nix
    ./screen-control.nix
    ./keepassxc.nix
    ./vscode.nix
    ./uxplay.nix
  ];
}
