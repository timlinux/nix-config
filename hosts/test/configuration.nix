# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # See vm-test-environment.sh in top of nix-config repo 
  # See https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  4096; # Use 2048MiB memory.
      cores = 3;         
    };
  };

  imports =
    [ 
      # this needs to be first
      ../../config/console-apps.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../config/bootsplash.nix
      ../../config/appimage.nix
      ../../config/avahi.nix
      ../../config/biometrics.nix
      ../../config/dir-env.nix
      ../../config/docker.nix
      ../../config/fwupd.nix
      ../../config/fonts.nix
      ../../config/games.nix
      ../../config/display-server.nix
      ../../config/gnome-desktop-wayland.nix
      ../../config/gnome-desktop-gdm.nix
      ../../config/gnome-desktop-apps.nix
      ../../config/gnome-desktop-extensions.nix
      ../../config/gnome-desktop-themes.nix
      ../../config/gui-apps.nix
      ../../config/iphone.nix
      ../../config/locale-pt-en.nix
      ../../config/keepassxc.nix
      ../../config/localsend.nix
      ../../config/ntfs.nix
      ../../config/obs.nix
      ../../config/printing.nix
      ../../config/quickemu.nix # Run VMS easily
      ../../config/qgis.nix
      ../../config/screen-control.nix
      ../../config/ssh.nix
      ../../config/starship.nix
      ../../config/syncthing.nix
      ../../config/tailscale.nix
      ../../config/uxplay.nix
      ../../config/vim.nix
      ../../config/vscode.nix
      ../../config/unstable-apps.nix
      ../../config/wine.nix
      ../../config/virt.nix
      ../../users/all.nix
      ../../users/tim.nix
      ../../users/guest.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  networking.hostName = "test"; # Define your hostname.
  networking.hostId = "d13e0d42"; # needed for zfs
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "22.11"; # Did you read the comment?

  ### Flakes support
  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ###
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;
}
