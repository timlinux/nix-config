{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./atuin
    ./bat
    ./bottom
    ./cava
    ./dircolors
    ./direnv
    ./eza
    ./fish
    ./fzf
    ./git
    ./github
    ./gitui
    ./ripgrep
    ./zoxide
    #./kartoza-nixos-utils
  ];
}
