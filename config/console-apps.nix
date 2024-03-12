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
    ls = "eza --icons=always";
    cat = "bat";
    find = "fd";
    l = "eza -alh --icons=always";
    ll = "eza -l --icons=always";
    psql = "pgcli";
    open = "xdg-open";
    ping = "gping";
    du = "dust";
    icat="kitty +kitten icat";
    # See https://github.com/kovidgoyal/kitty/issues/713#issuecomment-750704294
    ssh="kitty +kitten ssh";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    asciinema # record your console as ascii movies
    asciinema-agg # record your console as ascii movies
    asciinema-scenario # record your console as ascii movies
    bat # beter implementation of cat
    btop # another system monitor ui for console
    byobu # terminal multiplexer
    cowsay # Have a cow say stuff
    comma # handy "nix-shell -p" shortcut - just do ", programmename" and it does rather "nix-shell -p programmename"
    dua # better du command
    du-dust # another better du command - run as 'dust'
    eza # better ls command
    fd # a modern find implementation
    ffmpeg_5-full # create movies from the command line
    figlet # make text banners for your console
    fish # fish shell like bash but with lots of goodies
    git # well we all know what this is right?
    gh # github command line tool - see https://cli.github.com/
    gping # a better ping implementation
    gotop # system resource utilization console ui
    iftop # see what bandwidth is used on each network interface
    imagemagickBig # manipulate images on the command line see e.g. convert command
    kitty # nicer terminal emulator with a lot of cool features
    lazydocker # docker cli ui
    lazygit # git cli UI
    lftp # for remote backups
    mc # console file manager
    mdcat # render markdown in your shell
    ranger # console file manager
    ncdu # understand disk usage. Use dua rather, it is much faster
    neofetch # show stats of your system in terminal
    nethogs # see what apps are using up your bandwidth
    nix-direnv # see https://github.com/nix-community/nix-direnv
    pgcli # better psql client for postgres
    powertop # swee what apps use the most power on your machine
    restic # for local backups
    rpl # search and replace strings in files
    s3cmd # for backup of our devops s3 buckets
    unzip # unzip stuff
    usbutils # lsusb etc
    wget # fetch files over http
  ];
}
