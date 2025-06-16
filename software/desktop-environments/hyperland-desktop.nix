{
  config,
  pkgs,
  ...
}: {
  # Enable the X server.
  services.xserver.enable = true;
  # Enable the hyperland compositor.
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.enableNvidiaPatches = true;
  # Enable a display manager (recommended).
  services.xserver.displayManager.sddm.enable = true;
  environment.variables = {
    # Hack for broken drag and drop in Qt apps - only works in wayland
    #QT_QPA_PLATFORM = "wayland";
    # Hack to make Qt apps run with a light qt theme
    GTK_THEME = "Adwaita";
    #QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_STYLE_OVERRIDE = "adwaita"; # Set this using the qt5ct tool rather than here
    # See also gui-apps.nix for qt5ct
  };
}
