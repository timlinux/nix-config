{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Dell p172g bios linux
  # Dell Inspiron 14 7430 2in1

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/system/zfs-encryption.nix
    ../software/desktop-apps-unstable/keepassxc-unstable.nix
    ../software/desktop-apps-unstable/vscode-unstable.nix
    #../software/gis/qgis-unstable.nix
    ../software/gis/qgis.nix
    ../software/desktop-apps-unstable/uxplay-unstable.nix
    ../software/system/locale-za-en.nix
    ../users/tim.nix
    ../users/dorah.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "NIXROOT/root";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "NIXROOT/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    #device = "/dev/vda1";
    #use uuid rather
    device = "/dev/disk/by-uuid/4335-785C";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "NIXROOT/home";
    fsType = "zfs";
  };
  swapDevices = [];

  networking.hostName = "atoll"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "69a880f0"; # needed for zfs

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
