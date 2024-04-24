{
  config,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Currently I have issues running wayland like flashing windows etc.
  # if enabling this with the nvidia driver so be sure to
  # switch off nvidia dribers in configuration.nix if using this
  services.xserver.displayManager.gdm.wayland = false;

  # Also have the Qt theme env var set
  qt.platformTheme = "gnome";
  environment.variables = {
    # Hack for broken drag and drop in Qt apps (including QGIS) - only works in wayland
    # QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    QT_STYLE_OVERRIDE = "adwaita";
  };

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

  # QGnomePlatform seems to be the magic trick for fixing drag and drop issues
  # with QGIS and for making QGIS match the gnome theme
  # see also qt.plaformTheme directive below which will set the following env var:
  # QT_QPA_PLATFORMTHEME gnome
  environment.systemPackages = with pkgs; [
    # See https://github.com/FedoraQt/QGnomePlatform#usage
    qgnomeplatform # make Qt apps look like Gtk if they do not specifiy their own theme
  ];

  programs.seahorse.enable = true;
}
