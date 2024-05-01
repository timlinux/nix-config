{pkgs, ...}: {
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    fish # fish shell like bash but with lots of goodies
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
  ];
}
