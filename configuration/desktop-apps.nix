{
  config,
  pkgs,
  ...
}: {
  #TODO: Move this to modules? It doesnt inherit base...
  imports = [
    ../software/system/appimage.nix
    ../software/developer/dir-env.nix
    ../software/system/flatpak.nix
    ../software/system/fonts.nix
    ../software/games #equivalent to ../software/games/default.nix
    ../software/desktop-apps/gnome-desktop-apps.nix
    ../software/desktop-environments/gnome-desktop-extensions.nix
    ../software/desktop-environments/gnome-desktop-themes.nix
    ../software/desktop-apps/gui-apps.nix
    ../software/desktop-apps/iphone.nix
    ../software/desktop-apps/localsend.nix
    ../software/desktop-apps/obs.nix
    ../software/desktop-apps/keepassxc.nix
    ../software/desktop-apps/uxplay.nix
    #../software/system/postgres.nix
    ../software/system/quickemu.nix
    ../software/desktop-apps/screen-control.nix # android screen sharint
  ];
}
