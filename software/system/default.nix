{
  config,
  lib,
  ...
}: {
  imports = [
    # Keep this to generic items that would go on any system
    ../software/system/wine.nix
    ../software/system/avahi.nix
    ../software/system/biometrics.nix
    ../software/system/bluetooth.nix
    ../software/system/cert.nix #TODO - automate config of cert
    ../software/system/sound.nix
    ../software/system/yubikey.nix
    ../software/system/docker.nix
    ../software/system/fetchers.nix
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
