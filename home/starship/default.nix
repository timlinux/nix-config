{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # This does not work so at the moment we have
    # the global kitty config in modules/kitty.nix
    # Configuration written to ~/.config/starship.toml
    #settings = { builtins.readFile ../../dotfiles/starship.toml };
  };
}
