{
  config,
  desktop,
  hostname,
  inputs,
  lib,
  outputs,
  pkgs,
  stateVersion,
  username,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  isLima = builtins.substring 0 5 hostname == "lima-";
  isWorkstation =
    if (desktop != null)
    then true
    else false;
  isTimMachine =
    if (hostname == "crest" || hostname == "waterfall" || hostname == "valley")
    then true
    else false;
in {
  # These lines will be added to global  bashrc
  environment.interactiveShellInit = ''
    echo "Hello from michelle.nix"
  '';
  # I tried just adding this in the fish module
  # but it doesnt work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michelle = {
    isNormalUser = true;
    initialPassword = "michelle";
    description = "Michelle von Maltitz";
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

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./public-keys/id_ed25519_tim.pub)
      #TODO: add Michelle's key too
    ];
    packages = with pkgs; [
    ];
  };
  home-manager = {
    users.michelle.home.stateVersion = "23.11";
    users.michelle = {
      imports = [
        ../home/default.nix
      ];
      # Set to null to let GnuPG decide what signing key to use depending on commit’s author.p

      programs = {
        git = {
          userName = "Michelle von Maltitz";
          userEmail = "michelle@kartoza.com";
          # rest of git is configured in ../home/git..
          extraConfig = {
            github.user = "mvmaltitz";
            gitlab.user = "michelle@kartoza.com";
          };
        };
      };
    };
  };
}
