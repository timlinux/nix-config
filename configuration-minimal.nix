# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    config/console-apps.nix
    config/bootsplash.nix
    config/display-server.nix
    config/gnome-desktop-wayland.nix
    config/gnome-desktop-gdm.nix
    config/gnome-desktop-apps.nix
    config/gnome-desktop-extensions.nix
    config/gnome-desktop-themes.nix
    config/grub-theme.nix
    config/harden.nix
    config/locale-pt-en.nix
    config/ssh.nix
    config/starship.nix
    config/tailscale.nix
    config/vim.nix
    config/zfs.nix
    users/all.nix
    users/tim.nix
    users/guest.nix
  ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # See https://github.com/mcdonc/p51-thinkpad-nixos/tree/zfsvid
  # for notes on how I set up zfs
  services.zfs.autoScrub.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.requestEncryptionCredentials = true;

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
    home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  ### Flakes support

  ### See https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  ###
  ### Bleeding edge kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
