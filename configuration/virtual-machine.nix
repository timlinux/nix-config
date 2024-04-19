{
  config,
  lib,
  pkgs,
  ...
}: {
  
  
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../modules/appimage.nix
    ../modules/dir-env.nix
    ../modules/fonts.nix
    ../modules/display-server.nix
    ../modules/gnome-desktop-wayland.nix
    ../modules/gnome-desktop-gdm.nix
    ../modules/gnome-desktop-apps.nix
    ../modules/gnome-desktop-extensions.nix
    ../modules/gnome-desktop-themes.nix
    ../modules/gui-apps.nix
    ../modules/localsend.nix
    ../modules/syncthing.nix
    ../modules/vim.nix
    ../modules/zfs-encryption.nix
    ../users/guest.nix
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
