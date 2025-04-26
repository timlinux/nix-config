{
  config,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment - Wayland
  # Currently I have issues running wayland like flashing windows etc.
  # if enabling this with the nvidia driver so be sure to
  # switch off nvidia drivers in configuration.nix if using this
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.xwayland.enable = true;

  environment.variables = {
    # Hack for broken drag and drop in Qt apps (including QGIS) - only works in wayland
    QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    QT_STYLE_OVERRIDE = "adwaita";
  };

  #qt.platformTheme = "gnome";
  # Set the background by default to Kartoza branding
  # Note that it will not override the setting if it already exists
  # so only visible on new installs
  environment.etc."kartoza-wallpaper.png" = {
    mode = "0555";
    source = ../../resources/kartoza-wallpaper.png;
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
  # Todo : check what these do
  #gnome = {
  #core-utilities.enable = false;
  #tracker-miners.enable = false;
  #tracker.enable = false;
  #};
  # Required for ssh-askpass.
  programs.seahorse.enable = true;

  # Ensure GNOME's power daemon is running properly
  # this is needed for power management so that we can
  # suspend the system if battery is low
  services.gnome.gnome-settings-daemon.enable = true;
}
