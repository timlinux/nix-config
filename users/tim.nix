{pkgs, ...}: {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from tim.nix"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timlinux = {
    isNormalUser = true;
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
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [(builtins.readFile ./public-keys/id_ed25519_tim.pub)];
    packages = with pkgs; [
      popcorntime
      freetube
      tailscale
    ];
  };
  home-manager = {
    users.timlinux.home.stateVersion = "23.11";
    users.timlinux = {
      imports = [
        ../home/default.nix
      ];
      #programs.git.config.user.name = "Tim Sutton";
      #programs.git.config.user.email = "tim@kartoza.com";
    };
  };
}
