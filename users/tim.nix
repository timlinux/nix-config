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

  # Set any env vars here
  environment.variables = {
     # For nix-shell -p invocations you that need unfree packages
     # Note you still need to also pass the --impure command line flag
     NIXPKGS_ALLOW_UNFREE="1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    description = "Tim Sutton";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      hugo
      popcorntime
    ];
  };
}
