{ pkgs, ... }:

{

  environment.interactiveShellInit = ''
    # Add anything that must be in bashrc here
    echo "Sample bashrc line"
  '';

  # Example of how to add a config file in etc
  #environment.etc."starship.toml" = {
    #mode = "0555";
    #source = ../dotfiles/starship.toml;
  #};

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Example of adding aliases for bash commands
  programs.bash.shellAliases = {
    ls = "exa";
    cat = "bat";
    find = "fd";
    l = "ls -alh";
    ll = "ls -l";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    exa
    bat
    fd
    git
    imagemagickBig
    ffmpeg_5-full
    mc
    ncdu
    wget
    gotop
    nethogs
    iftop
    btop
  ];
}
