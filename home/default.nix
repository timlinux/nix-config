{pkgs, config, ...}: {
  imports = [
    ./gtk/default.nix
    ./kitty/default.nix
    ./starship/default.nix
    ./direnv/default.nix
    ./xdg/default.nix
    ./git/default.nix
  ];
  home.file."Kartoza.txt".text = "This computer is property of Kartoza.com";
  #programs.starship = {
  #  enable = true;
  #  settings = ''
  #    ${builtins.readFile ../dotfiles/starship.toml.nix}
  #  '';
  #};
  #home.file."starship.toml".text = builtins.readFile ../dotfiles/starship.toml;
  

}
