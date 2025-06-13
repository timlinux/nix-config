{
  config,
  pkgs,
  ...
}: {
  # See also software/desktop-environments/gnome-desktop-extensions.nix
  # search for shell to see how we set the shell theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      #package = pkgs.theme-obsidian2;
    };
    iconTheme = {
      name = "Adwaita";
      #package = pkgs.theme-obsidian2;
    };
    cursorTheme = {
      name = "Adwaita";
      #package = pkgs.theme-obsidian2;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  # Add adwaita-qt to system packages
  home.packages = with pkgs; [
    adwaita-qt
    adwaita-qt6
  ];

  # Set environment variables for Qt5 and Qt6 to use Adwaita-Qt
  home.sessionVariables = {
    GTK_THEME = "Adwaita";
    QT_QPA_PLATFORMTHEME = "adwaita";
    QT_STYLE_OVERRIDE = "adwaita";
  };
}
