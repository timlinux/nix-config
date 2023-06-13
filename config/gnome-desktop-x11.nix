{ config, pkgs, ... }:

# Workaround for thus bug is to (for now) use unstable gnome-shell
# https://github.com/NixOS/nixpkgs/issues/230097#issuecomment-1584637482
  
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    { config = config.nixpkgs.config; };
in {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Currently I have issues running wayland like flashing windows etc.
  # if enabling this with the nvidia driver so be sure to 
  # switch off nvidia dribers in configuration.nix if using this
  services.xserver.displayManager.gdm.wayland = false;

  environment.variables = {
    # Hack for broken drag and drop in Qt apps (including QGIS) - only works in wayland
    # QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    QT_STYLE_OVERRIDE = "adwaita";
  };

  qt.platformTheme = "gnome";
  # Set the background by default to Kartoza branding
  # Note that it will not override the setting if it already exists
  # so only visible on new installs
  environment.etc."kartoza-wallpaper.png" = {
    mode = "0555";
    source = ../resources/kartoza-wallpaper.png;
  };
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.background]
    picture-uri='file:///etc/kartoza-wallpaper.png'
    picture-uri-dark='file:///etc/kartoza-wallpaper.png'
  '';
  environment.interactiveShellInit = ''
    # Set manually like this (once for light theme, once for dark)
    gsettings set org.gnome.desktop.background picture-uri file:///etc/kartoza-wallpaper.png
    gsettings set org.gnome.desktop.background picture-uri-dark file:///etc/kartoza-wallpaper.png
  '';
 
  # Probably not needed, remove when unstable fix mentioned at top of file not needed
  #environment.systemPackages = with pkgs; [
  #    gnome-shell
  #  ];
}
