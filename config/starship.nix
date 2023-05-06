{ pkgs, ... }:

{
  environment.interactiveShellInit = ''
    eval "$(starship init bash)"
  '';

  environment.etc."starship.toml" = {
    mode = "0555";
    source = ../dotfiles/starship.toml;
  };

  environment.variables = {
    STARSHIP_CONFIG = "/etc/starship.toml";
  };

  environment.systemPackages = with pkgs; [
    starship
  ];
}
