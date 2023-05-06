{ pkgs, ... }:

{
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from tim.nix"
  '';

  # Add any aliases to bashrc
  programs.bash.shellAliases = {
    # ls = "exa";
  };

  # Create any config files you want in /etc
  environment.etc."starship.toml" = {
    #mode = "0555";
    #source = ../dotfiles/starship.toml;
  };

  # Set any env vars here
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      hugo
    ];
  };
}
