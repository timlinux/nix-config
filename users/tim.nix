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
  username = "timlinux";
  # copy over desktop monitor config to gdm for log in
  # see https://discourse.nixos.org/t/gdm-monitor-configuration/6356/4
  monitorsXmlContent = builtins.readFile /home/${username}/.config/monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in {
  # copy over desktop monitor config to gdm for log in
  # see https://discourse.nixos.org/t/gdm-monitor-configuration/6356/4
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];
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
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "${username}";
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
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./public-keys/id_ed25519_tim.pub)
    ];
    packages = with pkgs; [
      popcorntime
      freetube
    ];
  };

  # Shameless hardcoding here for now
  # We want this folder mounted in a location
  # That will be the same for all users and hosts
  # so that we can share OBS scene configs
  fileSystems."/home/KartozaInternal" = {
    device = "/home/${username}/Syncthing/KartozaInternal";
    fsType = "none";
    options = ["bind" "rw"];
  };

  home-manager = {
    # Set backup file extension - any config file collisions will be backed up
    backupFileExtension = ".bak";
    users.${username} = {
      home.stateVersion = "23.11";
      imports = [
        ../home
        # Not provisioned to all users...
        ../home/home-config/web-apps/chromium/proton-mail.nix
      ];
      programs = {
        git = {
          userName = "Tim Sutton";
          userEmail = "tim@kartoza.com";
          extraConfig = {
            github.user = "timlinux";
            gitlab.user = "tim@kartoza.com";
          };
          # rest of git is configured in ../home/git..
        };
      };
    };
  };
}
