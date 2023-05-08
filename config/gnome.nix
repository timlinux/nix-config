{ pkgs, ... }:

{
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
}

