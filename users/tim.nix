{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from tim.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
    initialPassword = "timlinux";
    description = "Tim Sutton";
    extraGroups = [
      "wheel"
      "disk"
      "libvirtd"
      "dialout" # needed for arduino
      "docker"
      "audio"
      "video"
      "input"
      "systemd-journal"
      "networkmanager"
      "network"
      "davfs2"
      "adbusers"
      "scanner"
      "lp"
      "lpadmin"
      "i2c"
    ];
    #already set in fish module
    #shell = pkgs.fish;
    openssh.authorizedKeys.keys = [(builtins.readFile ./public-keys/id_ed25519_tim.pub)];
    packages = with pkgs; [
      popcorntime
      freetube
    ];
  };
  home-manager = {
    users.timlinux.home.stateVersion = "23.11";
    users.timlinux = {
      imports = [
        ../home/default.nix
        ../home/keybindings/gnome.nix
      ];
      #programs.git.config.user.name = "Tim Sutton";
      #programs.git.config.user.email = "tim@kartoza.com";
    };
  };
}
