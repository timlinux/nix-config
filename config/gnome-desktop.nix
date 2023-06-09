{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Currently I have issues running wayland like flashing windows etc.
  services.xserver.displayManager.gdm.wayland = false

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

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    emote # emoji picker
    gnomeExtensions.notes
    gpick
    citations
    emblem
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    gnome.gnome-terminal
    shortwave # Internet streaming radio player
    eyedropper # nice simple colour picker
    gaphor # Uml diagramming app
    #lorem
    solanum
    gnome.gnome-boxes
    (gnome.gnome-boxes.override {
      qemu-utils = qemu-utils.override {
        qemu = qemu_kvm;
      };
    })
  ];
}
