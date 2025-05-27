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
  isWorkstation = desktop != null;
  isTimMachine = hostname == "crest" || hostname == "waterfall" || hostname == "valley";
  username = "lova";
  # copy over desktop monitor config to gdm for log in
  # see https://discourse.nixos.org/t/gdm-monitor-configuration/6356/4
  #monitorsXmlContent = if isTimMachine then builtins.readFile "/home/${username}/.config/monitors.xml" else "";
  #monitorsConfig = if isTimMachine then pkgs.writeText "gdm_monitors.xml" monitorsXmlContent else null;
in {
  #_module.args.hostname = hostname;

  # copy over desktop monitor config to gdm for log in
  # see https://discourse.nixos.org/t/gdm-monitor-configuration/6356/4
  #systemd.tmpfiles.rules = if isTimMachine then [
  #  "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  #] else [];

  # I tried just adding this in the fish module
  # but it doesn't work so we need to add it
  # for each user
  programs.fish.interactiveShellInit = ''
    starship init fish | source
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "${username}";
    description = "Lova";
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
    openssh.authorizedKeys.keys = [(builtins.readFile ./public-keys/id_ed25519_lova.pub)];
    packages = with pkgs; [
      popcorntime
      freetube
    ];
  };

  home-manager = {
    # Set backup file extension - any config file collisions will be backed up
    backupFileExtension = ".bak2";
    users.${username} = {
      home.stateVersion = "24.11";
      imports = [
        ../home
        # Not provisioned to all users...
        #../home/home-config/web-apps/chromium/proton-mail.nix
      ];
      programs = {
        git = {
          userName = "Xpirix";
          userEmail = "lova@kartoza.com";
          extraConfig = {
            github.user = "Xpirix";
            gitlab.user = "lova@kartoza.com";
          };
          # rest of git is configured in ../home/git..
        };
      };
    };
  };

  # Set the background by default to QGIS branding
  # Note that it will not override the setting if it already exists
  # so only visible on new installs
  environment.etc."QGIS_wallpaper.png" = {
    mode = "0555";
    source = ../resources/QGIS_wallpaper.png;
  };
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.background]
    picture-uri='file:///etc/QGIS_wallpaper.png'
    picture-uri-dark='file:///etc/QGIS_wallpaper.png'
  '';

  # These lines will be added to global bashrc
  environment.interactiveShellInit = ''
    echo "Hello from lova.nix"
    # Set manually like this (once for light theme, once for dark)
    gsettings set org.gnome.desktop.background picture-uri file:///etc/QGIS_wallpaper.png
    gsettings set org.gnome.desktop.background picture-uri-dark file:///etc/QGIS_wallpaper.png
  '';
}
