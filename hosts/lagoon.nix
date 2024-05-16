{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Vicky Laptop

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/system/locale-pt-en.nix
    ../software/system/biometrics.nix
    ../software/system/zfs-encryption.nix
    ../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay
    ../software/system/podman.nix
    ../software/system/distrobox.nix
    ../software/system/virt.nix
    ../software/system/sanoid.nix
    ../users/vicky.nix
    ../users/tim.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "NIXROOT/root";
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
  networking.hostId = "d43e0d41"; # needed for zfs
  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
