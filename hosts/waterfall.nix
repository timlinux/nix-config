{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-pt-en.nix
    ../modules/yubikey-auth.nix # for logging in to your system using yubikey
    ../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay
    ../users/tim.nix
  ];

  networking.hostName = "waterfall"; # Define your hostname.
  networking.hostId = "384bb6a1"; # needed for zfs

  # Bootloader. - carried over from original configuration.nix
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # Setup keyfile - carried over from original configuration.nix
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Rest of this file carried over from carried over from original hardware-configuration.nix

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/47860b62-6335-4d90-b6e7-74d34c11e5f9";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-7b89d043-425d-4e0f-bbeb-a1122fa2b930".device = "/dev/disk/by-uuid/7b89d043-425d-4e0f-bbeb-a1122fa2b930";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/C4B6-A7C9";
      fsType = "vfat";
    };

  fileSystems."/home/timlinux/gisdata" =
    { device = "/dev/disk/by-uuid/ec7da9cf-6a66-4ae3-a426-bde65b571e6e";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/ef689831-6c83-442c-9a4e-49821cc24d07";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."luks-ecea0325-79ab-4efc-adff-74de4982836f".device = "/dev/disk/by-uuid/ecea0325-79ab-4efc-adff-74de4982836f";

  fileSystems."/home/backups" =
    { device = "/dev/disk/by-uuid/a04d9c57-56ba-4e4d-a71e-36f1adf24fc4";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."luks-b7dae669-00f7-4708-bf5a-858b0e70641e".device = "/dev/disk/by-uuid/b7dae669-00f7-4708-bf5a-858b0e70641e";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}