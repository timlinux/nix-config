{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../configuration/desktop-gnome.nix
      ../users/guest.nix
      ../users/tim.nix
    ];
  # See vm-test-environment.sh in top of nix-config repo
  # See https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
  virtualisation.vmVariant = {
    # following configuration is added only when building nixos with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 4;
    };
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  networking.hostName = "test"; # Define your hostname.

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a49497bc-650a-460b-9f52-1df2c66c8d58";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/298F-02EA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f1b89024-4cd9-484e-8759-7621a8e173ff"; }
    ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
