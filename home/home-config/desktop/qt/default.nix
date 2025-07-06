{
  config,
  pkgs,
  ...
}: {
  # Set environment variables for Qt5 and Qt6 to use Adwaita-Qt
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_STYLE_OVERRIDE = "adwaita"; # Set this using the qt5ct tool rather than here
    # See also gui-apps.nix for qt5ct
  };
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];
}
