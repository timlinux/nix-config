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
    # I disabled this because I think it is better to introduce it
    # in shell.nix since it avoids creating a globally configured instance...
    # see the vscode.sh script in this repo for a good example of how to
    # configure vscode in a shell.nix file.
    #./vscode.nix
    ./uxplay.nix
  ];
}
