{ config, pkgs, ... }:

{
  # Enable the X server.
  services.xserver.enable = true;
  # Enable the Budgie Desktop.
  services.xserver.desktopManager.cinnamon.enable = true;
  # Enable a display manager (recommended).
  services.xserver.displayManager.lightdm.enable = true;
  environment.variables = {
    # Hack for broken drag and drop in Qt apps - only works in wayland
    #QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    QT_STYLE_OVERRIDE = "adwaita";
  };
}
