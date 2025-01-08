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
    #./cava
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
    ./kartoza-nixos-utils
    ./fastfetch
  ];

  home = {
    sessionVariables = {
      EDITOR = "vim";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
      MANROFFOPT = "-c";
      PAGER = "bat";
      SYSTEMD_EDITOR = "bat";
      VISUAL = "vim";
    };
  };
}
