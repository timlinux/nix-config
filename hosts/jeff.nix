{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-kde.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-ke-en.nix
    #../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay

    # I do it this way so that we use hand compiled QGIS with
    # all the extra goodies I want like pyqtgraph
    # rasterio, debug libs etc. available to the build of QGIS
    # Note that it is mutually exclusive (for now) to the upstream
    # QGIS binaries and also the build may take quite a while on
    # your pc. If you prefer to use the upstream built binary,
    # you can comment out these next 4 lines and uncomment the
    # unstable-apps entry above.
    ../modules/keepassxc.nix
    ../modules/vscode.nix
    ../modules/uxplay.nix
    ../modules/qgis-dev.nix

    ../users/jeff.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/552630ad-82e3-45c2-9255-131fcc3c32db";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/94c38b60-650b-44b8-9dd7-ef5c711a49ff";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
