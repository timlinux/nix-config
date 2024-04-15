{
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = { builtins.readFile ../../dotfiles/starship.toml };
  };
}
