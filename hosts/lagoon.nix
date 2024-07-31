{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Vicky Laptop HP envy x360 2-in-1 laptop 14-es0033dx
  nixpkgs.config.cudaSupport = false;
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/system/locale-ke-en.nix
    #../software/system/biometrics.nix
    ../software/system/zfs-encryption.nix
    ../software/desktop-apps-unstable # keepasxc, vscode, uxplay
    ../software/gis/qgis-stable.nix
    #../software/gis/qgis-sourcebuild.nix
    #../software/system/podman.nix
    #../software/system/distrobox.nix
    ../software/system/virt.nix
    ../software/system/sanoid.nix
    ../users/vicky.nix
    ../users/tim.nix
    ../software/developer/awscli.nix
    ../software/system/docker.nix
    ../software/developer/pycharm-professional.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  #systemd.targets.sleep.enable = false;
  #systemd.targets.suspend.enable = false;
  #systemd.targets.hibernate.enable = false;
  #systemd.targets.hybrid-sleep.enable = false;

  fileSystems."/" = {
    device = "NIXROOT/root";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "NIXROOT/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EB5C-D827";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "NIXROOT/home";
    fsType = "zfs";
  };

  networking.hostName = "lagoon"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "ebb1053f"; # needed for zfs
  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
