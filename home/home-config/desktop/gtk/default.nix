{
  config,
  pkgs,
  ...
}: {
  # ──────────────────────────────────────────────────────────────────────────────
  #  GTK & Qt THEME CONFIGURATION
  #  This module sets up a unified, modern look for both GTK and Qt applications,
  #  ensuring a consistent and elegant desktop experience.
  # ──────────────────────────────────────────────────────────────────────────────

  gtk = {
    enable = true;

    # ── GTK THEME ───────────────────────────────────────────────────────────────
    theme = {
      name = "Adwaita"; # The classic GNOME look: clean, simple, and beautiful.
      # package = pkgs.theme-obsidian2; # Uncomment to try a different theme!
    };

    # ── ICON THEME ──────────────────────────────────────────────────────────────
    iconTheme = {
      name = "Adwaita"; # Harmonious icons for a seamless desktop.
      # package = pkgs.theme-obsidian2;
    };

    # ── CURSOR THEME ────────────────────────────────────────────────────────────
    cursorTheme = {
      name = "Adwaita"; # Elegant cursor for a polished feel.
      # package = pkgs.theme-obsidian2;
    };

    # ── GTK3 SPECIFIC SETTINGS ─────────────────────────────────────────────────
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = false; # Prefer dark mode for comfort.
    };
  };

  # ──────────────────────────────────────────────────────────────────────────────
  #  EXTRA GTK/Qt PACKAGES
  #  Add Adwaita-Qt for a consistent look in Qt5 and Qt6 applications.
  # ──────────────────────────────────────────────────────────────────────────────
  # ── EXTRA THEMES & INTEGRATION PACKAGES ──────────────────────────────────────
  home.packages = with pkgs; [
    # Adwaita theme for a unified look across GTK and Qt applications
    # Looks horrible in gnome-shell, so disabled by default
    #adwaita-qt   # Qt5: Native Adwaita theme
    #adwaita-qt6  # Qt6: Native Adwaita theme

    # Add more GTK/Qt theme or icon packages below as desired
    # e.g., gnome-themes-extra, papirus-icon-theme, etc.
  ];

  # ──────────────────────────────────────────────────────────────────────────────
  #  ENVIRONMENT VARIABLES
  #  Ensure both GTK and Qt applications use the Adwaita theme by default.
  # ──────────────────────────────────────────────────────────────────────────────
  home.sessionVariables = {
    GTK_THEME = "Adwaita"; # Set GTK theme globally for Qt apps
  };
}
