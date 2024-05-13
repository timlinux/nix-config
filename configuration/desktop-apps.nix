{
  config,
  pkgs,
  ...
}: {
  #TODO: Move this to modules? It doesnt inherit base...
  imports = [
    ../modules/appimage.nix
    ../modules/dir-env.nix
    ../modules/flatpak.nix
    ../modules/fonts.nix
    ../modules/games.nix
    ../modules/gnome-desktop-apps.nix
    ../modules/gnome-desktop-extensions.nix
    ../modules/gnome-desktop-themes.nix
    ../modules/gui-apps.nix
    ../modules/iphone.nix
    ../modules/localsend.nix
    ../modules/obs.nix
    #../modules/postgres.nix
    ../modules/python.nix
    ../modules/quickemu.nix
    ../modules/screen-control.nix # android screen sharint
    ../modules/steam.nix
    ../modules/wine.nix

    ../modules/avahi.nix
    ../modules/biometrics.nix
    ../modules/bluetooth.nix
    ../modules/cert.nix #TODO - automate config of cert
    ../modules/sound.nix
    ../modules/yubikey.nix
    ../modules/docker.nix
    ../modules/fetchers.nix
    ../modules/fwupd.nix
    ../modules/ntfs.nix
    ../modules/printing.nix
    ../modules/ssdtrim.nix
    ../modules/syncthing.nix
    ../modules/tailscale.nix
    ../modules/tlp.nix
    ../modules/zfs-sanoid.nix
    ../modules/trezor.nix
    ../modules/virt.nix
  ];
}
