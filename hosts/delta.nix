{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Lenovo Ideapad Flex5
  # No ZFS and using cryptfs
  # Amy Laptop

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/desktop-apps-unstable/keepassxc-unstable.nix
    ../software/desktop-apps-unstable/vscode-unstable.nix
    #../software/gis/qgis-unstable.nix
    ../software/gis/qgis-stable.nix
    #../software/desktop-apps-unstable/uxplay-unstable.nix
    ../software/system/locale-za-en.nix
    ../users/amz.nix
    ../users/tim.nix
  ];

  # Non ZFS hosts only for this section
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  #boot.initrd.luks.devices."luks-f4166935-5b7d-4a27-9b61-0d751d324ce9".device = "/dev/disk/by-uuid/f4166935-5b7d-4a27-9b61-0d751d32   4ce9";
  #boot.initrd.luks.devices."luks-f4166935-5b7d-4a27-9b61-0d751d324ce9".keyFile = "/crypto_keyfile.bin";

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1e2cefdd-8e4f-4208-81e8-8bbcd2719d64";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-04990889-c093-4272-9ca5-0bed5e068a7e".device = "/dev/disk/by-uuid/04990889-c093-4272-9ca5-0bed5e068a7e";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0397-B13C";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f4166935-5b7d-4a27-9b61-0d751d324ce9";}
  ];

  networking.hostName = "delta"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "69a88099"; # needed for zfs

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
