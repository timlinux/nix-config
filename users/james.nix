{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from james.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeff = {
    isNormalUser = true;
    description = "Jeff";
    extraGroups = [
    ];
    #already set in fish module
    #shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
    ];
    packages = with pkgs; [
    ];
  };
  home-manager = {
    users.james.home.stateVersion = "25.05";
    users.jeff = {
      imports = [
        ../home/default.nix
      ];
.com";
    };
  };
}
