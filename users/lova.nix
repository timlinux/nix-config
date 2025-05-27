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
        kitty = {
          enable = true;
          shellIntegration.enableFishIntegration = true;
          extraConfig = ''
            # Start maximized
            map winmax toggle maximize_window
            # Kartoza Kitty Theme
            background_opacity 0.95
            font_size 12
            foreground #C3C7D1
            background #0D181E
            selection_foreground #C3C7D1
            selection_background #4f5b66
            url_color #3A9800
            active_border_color #93B023
            inactive_border_color #55828b
            cursor #3A9800
            cursor_text_color #C3C7D1
            scrollback_lines 10000
            hide_window_decorations no
            tab_activity_symbol 🔔
            tab_bar_style powerline
            tab_powerline_style angled
            tab_title_format '{title}'
            tab_title_style 'bold'
            tab_max_width '20%'
            tab_max_width_auto_shrink no
            tab_bar_background #395c6b
            active_tab_background #93B023
            tab_title_template "💻️ {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
            active_tab_title_template "⚙️ {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
            tab_font 'Hack, Monaco, "DejaVu Sans Mono", monospace'
          '';
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

  # Starship configuration

  environment.etc."starship-qgis.toml" = {
    mode = "0555";
    source = ../dotfiles/starship-qgis.toml;
  };

  environment.variables = {
    STARSHIP_CONFIG = lib.mkForce "/etc/starship-qgis.toml";
  };
}
