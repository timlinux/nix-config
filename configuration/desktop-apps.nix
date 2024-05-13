{
  config,
  pkgs,
  ...
}: {
  #TODO: Move this to modules? It doesnt inherit base...
  imports = [
    ../software/desktop-apps/appimage.nix
    ../software/desktop-apps/dir-env.nix
    ../software/desktop-apps/flatpak.nix
    ../software/desktop-apps/fonts.nix
    ../software/desktop-apps/games.nix
    ../software/desktop-apps/gnome-desktop-apps.nix
    ../software/desktop-apps/gnome-desktop-extensions.nix
    ../software/desktop-apps/gnome-desktop-themes.nix
    ../software/desktop-apps/gui-apps.nix
    ../software/desktop-apps/iphone.nix
    ../software/desktop-apps/localsend.nix
    ../software/desktop-apps/obs.nix
    #../software/desktop-apps/postgres.nix
    ../software/desktop-apps/python.nix
    ../software/desktop-apps/quickemu.nix
    ../software/desktop-apps/screen-control.nix # android screen sharint
    ../software/games/steam.nix
    ../software/system/wine.nix
    ../software/system/avahi.nix
    ../software/system/biometrics.nix
    ../software/system/bluetooth.nix
    ../software/system/cert.nix #TODO - automate config of cert
    ../software/system/sound.nix
    ../software/system/yubikey.nix
    ../software/system/docker.nix
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
