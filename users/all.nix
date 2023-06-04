{ pkgs, ... }:

{
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from all.nix"
  '';

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  programs.fish.shellAliases = {
    # ls = "exa";
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    #fishPlugins.grc
    #grc
  ];

  # Add any aliases to bashrc
  programs.bash.shellAliases = {
    # ls = "exa";
  };

  # Set any env vars here
  environment.variables = {
     # For nix-shell -p invocations you that need unfree packages
     # Note you still need to also pass the --impure command line flag
     NIXPKGS_ALLOW_UNFREE="1";
  };
}
