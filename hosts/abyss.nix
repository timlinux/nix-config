{
  config,
  lib,
  pkgs,
  geospatial,
  modulesPath,
  ...
}: {
  # Framework 16

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../software/system/locale-pt-en.nix
    ../software/system/biometrics.nix
    ../software/system/yubikey.nix
    ../software/system/zfs-encryption.nix
    ../software/gis/qgis-2.18.nix
    ../software/gis/qgis-latest-geospatialnix.nix
    ../software/gis/qgis-ltr-geospatialnix.nix
    #../software/system/wine.nix
    # Enable power management
    ../software/system/power.nix
    #../modules/unstable-apps.nix # qgis, keepasxc, vscode, uxplay

    # I do it this way so that we use hand compiled QGIS with
    # all the extra goodies I want like pyqtgraph
    # rasterio, debug libs etc. available to the build of QGIS
    # Note that it is mutually exclusive (for now) to the upstream
    # QGIS binaries and also the build may take quite a while on
    # your pc.   If you prefer to use the upstream built binary,
    # you can comment out these next line and uncomment the
    # unstable-apps entry above.
    #../software/gis/qgis-sourcebuild.nix
    #
    #../software/gis/tilemaker-sourcebuild.nix
    #../software/gis/whitebox-tools.nix
    #../software/gis/saga.nix
    # R&D Package for Wolfgang
    #../software/gis/gverify-sourcebuild.nix
    #../software/system/docker.nix
    ../software/system/fwupd.nix
    #../software/system/podman.nix
    #../software/system/distrobox.nix
    #../software/system/tty-font.nix
    ../software/system/tailscale.nix
    ../software/system/virt.nix
    # ../software/system/printing.nix
    ../software/system/sanoid.nix
    #../software/system/lima.nix
    ../software/desktop-apps/google-earth-pro.nix
    ../users/tim.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  #################### TODO Refactor this into modules ####################
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true; # optional, useful for home
  };

  services.fprintd.enable = true;

  # enable Power Profiles Daemon for improved battery life
  services.power-profiles-daemon.enable = true;

  # platform and cpu options
  #nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  #hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # enable non-root access to keyboard firmware
  hardware.keyboard.qmk.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # configure lid and power button behavior
  services.logind = {
    powerKey = "hibernate";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  #################### END TODO Refactor this into modules ####################

  # Needs NixOS 24.05
  # Set up a dns proxy so that we can use AdGuard Home as a DNS server
  # and use our internal DNS server for some domains.
  #services.dnsproxy = {
  #  enable = true;
  #  settings = ''
  #        {
  #      bootstrap = [
  #        "8.8.8.8:53"
  #      ];
  #      listen-addrs = [
  #        "0.0.0.0"
  #      ];
  #      listen-ports = [
  #        53
  #      ];
  #      upstream = [
  #        "192.168.0.2:53"
  #      ];
  #    }
  #        #  [[rules]]
  #        #  network = ["10.100.0.0/24", "10.31.0.0/24", "10.12.0.0/24", "10.20.0.0/24"]
  #        #  upstream = ["10.31.0.5"]
  #
  #        #  [[rules]]
  #        #  domain = ["*.kartoza.com"]
  #        #  upstream = ["10.31.0.5"]
  #  '';
  #};
  # Use DNS Proxy for DNS resolution
  #networking.nameservers = ["127.0.0.1"];
  # Or use our internal DNS server
  networking.nameservers = ["10.100.0.236"];

  #networking.nameservers = ["192.168.0.2"];
  #networking.firewall.allowedTCPPorts = [53];
  #networking.firewall.allowedUDPPorts = [53];
  # For revolt
  #networking.firewall.allowedTCPPorts = [80 443];
  #networking.firewall.allowedUDPPorts = [80 443];
  boot.initrd.luks.devices."luks-b363c176-a43c-4b4b-9716-6af8a7a438e6".device = "/dev/disk/by-uuid/b363c176-a43c-4b4b-9716-6af8a7a438e6";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/453bb92e-2ff3-4dbb-b08d-d7b1115857db";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-3779484a-469e-486c-bf12-5e1f1c97a0a1".device = "/dev/disk/by-uuid/3779484a-469e-486c-bf12-5e1f1c97a0a1";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/467B-C9EF";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/3b238706-1365-4042-9a05-430cb1cdb774";}
  ];

  #fileSystems."/home" = {
  #  device = "NIXROOT/home";
  #  fsType = "zfs";
  #};
  # Special mount point
  # See https://github.com/atuinsh/atuin/issues/952#issuecomment-1802376251
  #fileSystems."/home/timlinux/.local/share/atuin" = {
  #  device = "/dev/zvol/NIXROOT/atuin";
  #  fsType = "ext4";
  #};
  networking.hostName = "abyss"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "f6f9db57"; # needed for zfs

  networking.extraHosts = ''
    10.100.0.236 valley
    192.168.0.2 valley-local
    10.100.0.234 waterfall
    192.168.0.2 valley-local
    192.168.0.1 router
    10.100.0.242 vicky
    10.100.0.237 michelle
    10.100.0.243 amy
    10.100.0.246 eli
  '';

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
