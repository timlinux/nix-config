{
  pkgs,
  config,
  ...
}: {
  home.file."Kartoza.txt".text = "This computer is property of Kartoza.com";
  gpg.enable = true;
  home-manager.enable = true;
  info.enable = true;
  jq.enable = true;
  nix-index.enable = true;
  imports = [
    ./atuin/default.nix
    ./bat/default.nix
    ./bottom/default.nix
    ./bottom/dircolors.nix
    ./cava/default.nix
    ./eza/default.nix
    ./fish/default.nix
    ./fzf/default.nix
    ./gtk/default.nix
    ./kitty/default.nix
    ./direnv/default.nix
    ./xdg/default.nix
    ./git/default.nix
    ./github/default.nix
    ./gitui/default.nix
    ./powerline-go/default.nix
    ./ripgrep/default.nix
    ./zoxide/default.nix
  ];
}
