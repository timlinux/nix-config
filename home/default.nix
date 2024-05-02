{
  pkgs,
  config,
  ...
}: {
  home.file."Kartoza.txt".text = "This computer is property of Kartoza.com";
  programs = {
    gpg.enable = true;
    home-manager.enable = true;
    info.enable = true;
    jq.enable = true;
    nix-index.enable = true;
    aria2.enable = true;
  };

  imports = [
    ./atuin/default.nix
    ./bat/default.nix
    ./bottom/default.nix
    ./cava/default.nix
    ./dircolors/default.nix
    ./direnv/default.nix
    ./eza/default.nix
    ./fish/default.nix
    ./fzf/default.nix
    ./git/default.nix
    ./github/default.nix
    ./gitui/default.nix
    ./gtk/default.nix
    ./keybindings/gnome.nix
    ./kitty/default.nix
    ./ripgrep/default.nix
    ./xdg/default.nix
    ./zoxide/default.nix
  ];
}
