{
  config,
  pkgs,
  ...
}: {
  # See also modules/gnome-desktop-extensions.nix
  # search for shell to see how we set the shell theme
  gtk = {
    enable = true;
    theme = {
      name = "Obsidian-2-Aqua";
      package = pkgs.theme-obsidian2;
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
  home.sessionVariables.GTK_THEME = "Obsidian-2-Aqua";
}
