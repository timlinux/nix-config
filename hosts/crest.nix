{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Lenovo Thinkpad P14s AMD Gen 1

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/system/locale-pt-en.nix
    ../software/system/biometrics.nix
    ../software/system/zfs-encryption.nix
    #../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay

    # I do it this way so that we use hand compiled QGIS with
    # all the extra goodies I want like pyqtgraph
    # rasterio, debug libs etc. available to the build of QGIS
    # Note that it is mutually exclusive (for now) to the upstream
    # QGIS binaries and also the build may take quite a while on
    # your pc.   If you prefer to use the upstream built binary,
    # you can comment out these next 4 lines and uncomment the
    # unstable-apps entry above.
    ../software/desktop-apps-unstable/keepassxc-unstable.nix
    ../software/desktop-apps-unstable/vscode-unstable.nix
    ../software/desktop-apps-unstable/uxplay-unstable.nix
    ../software/gis/qgis-sourcebuild.nix
    ../software/system/sound-noise-suppression-unstable.nix
    ../software/gis/tilemaker-sourcebuild.nix
    # R&D Package for Wolfgang
    ../software/gis/gverify-sourcebuild.nix
    ../software/system/podman.nix
    ../software/system/distrobox.nix
    #../software/system/tty-font.nix
    ../software/system/tailscale.nix
    ../software/system/virt.nix
    ../software/system/sanoid.nix
    ../users/tim.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  # Use adguard for DNS on the valley NUC
  networking.nameservers = ["192.168.0.2"];

  # For revolt
  #networking.firewall.allowedTCPPorts = [80 443];
  #networking.firewall.allowedUDPPorts = [80 443];

  fileSystems."/" = {
    device = "NIXROOT/root";
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

  networking.hostName = "crest"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "d13e0d41"; # needed for zfs
  swapDevices = [];

  networking.extraHosts = ''
    192.168.0.2 valley
    192.168.0.1 router
  '';

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
