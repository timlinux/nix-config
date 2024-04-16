{ pkgs, ... }:

{
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

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

  environment.systemPackages = with pkgs; [
    fish # fish shell like bash but with lots of goodies
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    #fishPlugins.grc
    #grc
  ];


}
