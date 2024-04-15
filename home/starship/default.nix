{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = { builtins.readFile ../../dotfiles/starship.toml };
  };
}
