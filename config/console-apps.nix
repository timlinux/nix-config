{ pkgs, ... }:

{

  environment.interactiveShellInit = ''
    # Add anything that must be in bashrc here
    echo "Nix environment with setup configs by Tim."
    neofetch
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
  #programs.bash.shellAliases = {
  programs.fish.shellAliases = {
    ls = "exa";
    cat = "bat";
    find = "fd";
    l = "ls -alh";
    ll = "ls -l";
    psql = "pgcli";
    open = "xdg-open";
    ping = "gping";
    du = "dua";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    asciinema
    asciinema-agg
    asciinema-scenario
    bat
    btop
    byobu
    cowsay
    comma # handy "nix-shell -p" shortcut - just do ", programmename" and it does rather "nix-shell -p programmename"
    dua # better du command
    exa
    fd
    ffmpeg_5-full
    figlet
    fish # fish shell like bash but with lots of goodies
    git
    gping
    gotop
    iftop
    imagemagickBig
    lazydocker
    lazygit
    lftp # for remote backups
    mc
    ncdu
    neofetch
    nethogs
    nix-direnv # see https://github.com/nix-community/nix-direnv
    pgcli
    restic # for local backups
    unzip
    wget
  ];
}
