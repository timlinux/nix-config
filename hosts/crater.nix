{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-za-en.nix
    #../modules/biometrics.nix
    ../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay
    ../users/eli.nix
    ../users/tim.nix
  ];
  # Dell P157G Inspiron - Eli

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4a1f442c-e191-4f92-8b47-b580db36e463".device = "/dev/disk/by-uuid/4a1f442c-e191-4f92-8b47-b580db36e463";
  boot.initrd.luks.devices."luks-4a1f442c-e191-4f92-8b47-b580db36e463".keyFile = "/crypto_keyfile.bin";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/101afe2e-df68-4aad-baf6-8a34f113f92b";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-0ec8c0eb-d24f-4b80-a669-2619a125395a".device = "/dev/disk/by-uuid/0ec8c0eb-d24f-4b80-a669-2619a125395a";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/13F5-C2F9";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/b3802eab-0df1-4fe3-8ff9-c63a35fe86a7";}
  ];

  networking.hostName = "crater"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "598f6c07"; # needed for zfs

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
