{
  config,
  pkgs,
  ...
}: {
  #TODO: Move this to modules? It doesnt inherit base...
  imports = [
    ../software/system/appimage.nix
    ../software/desktop-apps/dir-env.nix
    ../software/system/flatpak.nix
    ../software/system/fonts.nix
    ../software/games #equivalent to ../software/games/default.nix
    ../software/desktop-apps/gnome-desktop-apps.nix
    ../software/desktop-environment/gnome-desktop-extensions.nix
    ../software/desktop-environment/gnome-desktop-themes.nix
    ../software/desktop-apps/gui-apps.nix
    ../software/desktop-apps/iphone.nix
    ../software/desktop-apps/localsend.nix
    ../software/desktop-apps/obs.nix
    #../software/system/postgres.nix
    ../software/developer/python.nix
    ../software/system/quickemu.nix
    ../software/desktop-apps/screen-control.nix # android screen sharint
    ../software/system
    ../software/desktop-apps/fetchers.nix
    ../software/system/fwupd.nix
    ../software/system/ntfs.nix
    ../software/system/printing.nix
    ../software/system/ssdtrim.nix
    ../software/system/syncthing.nix
    ../software/system/tailscale.nix
    ../software/system/tlp.nix
    ../software/system/zfs-sanoid.nix
    ../software/system/trezor.nix
    ../software/system/virt.nix
  ];
}
