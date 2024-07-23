{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Lenovo for Amy

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-za-en.nix
    ../software/system/zfs-encryption.nix
    ../software/desktop-apps-unstable/keepassxc-unstable.nix
    ../software/desktop-apps-unstable/vscode-unstable.nix
    ../software/desktop-apps-unstable/uxplay-unstable.nix
    ../software/gis/qgis-sourcebuild.nix
    ../software/gis/whitebox-tools.nix
    ../software/gis/saga.nix
    ../software/system/tailscale.nix
    ../software/system/virt.nix
    ../software/system/printing.nix
    ../software/system/sanoid.nix
    ../users/amy.nix
    ../users/tim.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  #networking.nameservers = ["10.100.0.236"];

  fileSystems."/" = {
    device = "NIXROOT/root";
    fsType = "zfs";
  };
  fileSystems."/nix" = {
    device = "NIXROOT/nix";
    fsType = "zfs";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EA5C-D827";
    fsType = "vfat";
  };
  fileSystems."/home" = {
    device = "NIXROOT/home";
    fsType = "zfs";
  };
  # Special mount point
  # See https://github.com/atuinsh/atuin/issues/952#issuecomment-1802376251
  #fileSystems."/home/amy/.local/share/atuin" = {
  #  device = "/dev/zvol/NIXROOT/atuin";
  #  fsType = "ext4";
  #};
  networking.hostName = "delta"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "69a88099"; # needed for zfs
  swapDevices = [];

  networking.extraHosts = ''
    10.100.0.236 valley
    10.100.0.234 waterfall
    192.168.0.2 valley-local
    192.168.0.1 router
    10.100.0.242 vicky
    100.100.0.237 michelle
  '';

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
