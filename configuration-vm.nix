{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      config/console-apps.nix
      config/bootsplash.nix
      config/appimage.nix
      config/avahi.nix
      config/biometrics.nix
      config/dir-env.nix
      config/docker.nix
      config/fwupd.nix
      config/fonts.nix
      config/games.nix
      config/display-server.nix
      config/gnome-desktop-wayland.nix
      config/gnome-desktop-gdm.nix
      config/gnome-desktop-apps.nix
      config/gnome-desktop-extensions.nix
      config/gnome-desktop-themes.nix
      config/gui-apps.nix
      config/grub-theme.nix
      config/harden.nix
      config/locale-pt-en.nix
      config/keepassxc.nix
      config/localsend.nix
      config/ntfs.nix
      config/obs.nix
      config/printing.nix
      config/qgis.nix # Upstream packaged version
      config/ssh.nix
      config/starship.nix
      config/steam.nix
      config/syncthing.nix
      config/tailscale.nix
      config/trezor.nix
      config/uxplay.nix
      config/vim.nix
      config/yubikey.nix
      config/unstable-apps.nix
      config/wine.nix
      config/virt.nix
      config/zfs.nix
      users/all.nix
      users/guest.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid \n
  # for notes on how I set up zfs
  services.zfs.autoScrub.enable = true;
  boot.loader.grub.enable = true; 
  boot.loader.grub.devices = ["nodev"]; 
  boot.loader.grub.efiInstallAsRemovable = true; 
  boot.loader.grub.efiSupport = true; 
  boot.loader.grub.useOSProber = true; 
  boot.supportedFilesystems = ["zfs"]; 
  boot.zfs.requestEncryptionCredentials = true; 
  boot.zfs.devNodes = "/dev/disk/by-path"; 
  services.xserver.videoDrivers = ["qxl"];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # needed for vm screen resizing, clipboard etc
    spice-vdagent 
    home-manager
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  xdg.portal.enable = true;
  services.flatpak.enable = true;

}

