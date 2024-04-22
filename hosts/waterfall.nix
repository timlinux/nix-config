{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-pt-en.nix
    ../modules/zfs-encryption.nix
    #../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay
    ../users/tim.nix
  ];

  networking.hostName = "waterfall"; # Define your hostname.
  networking.hostId = "80087915"; # needed for zfs
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "NIXROOT/root";
      fsType = "zfs";
    };  

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AFED-D8F9";
      fsType = "vfat";
    };  

  fileSystems."/home" =
    { device = "NIXROOT/home";
      fsType = "zfs";
    };  

  fileSystems."/nix" =
    { device = "NIXROOT/nix";
      fsType = "zfs";
    };  

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
