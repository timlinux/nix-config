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
    # Temporarily disabled due to issue
    # https://github.com/snowfallorg/nixos-conf-editor/issues/24
    # ./nixos-conf-editor.nix
    ./screen-control.nix
    ./keepassxc.nix
    ./vscode.nix
    ./uxplay.nix
  ];
}
