{
  config,
  lib,
  pkgs,
  geospatial,
  modulesPath,
  ...
}: {
  # Lovas Tuxedo Slim 16 with NVidia GPU 4070
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../configuration/desktop-gnome-x11.nix
    #../software/desktop-environments/gnome-desktop-remote-desktop.nix
    ../configuration/desktop-apps.nix
    ../software/system/locale-eu-en-madagascar.nix
    #../software/system/biometrics.nix
    ../software/system/zfs-encryption.nix
    ../software/gis/qgis-geospatialnix.nix
    #../software/system/wine.nix
    # Enable power management
    ../software/system/power.nix
    ../software/system/docker.nix
    #../software/system/podman.nix
    #../software/system/distrobox.nix
    ../software/system/tailscale.nix
    ../software/system/virt.nix
    ../software/system/printing.nix
    ../software/system/sanoid.nix
    ../software/system/nvidia-lova.nix
    #../software/system/tuxedo.nix
    #../software/system/lima.nix
    ../software/desktop-apps/google-earth-pro.nix
    ../users/tim.nix
    ../users/lova.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.kernelParams = ["acpi=rstd"]; # Added by Tim to remove bootup errors on Tuxedo laptops
  boot.extraModulePackages = [];

  networking.nameservers = ["10.100.0.236"];

  #networking.nameservers = ["192.168.0.2"];
  #networking.firewall.allowedTCPPorts = [53];
  #networking.firewall.allowedUDPPorts = [53];
  # For revolt
  #networking.firewall.allowedTCPPorts = [80 443];
  #networking.firewall.allowedUDPPorts = [80 443];

  fileSystems."/" = {
    device = "NIXROOT/root";
    fsType = "zfs";
  };

  # If you installed using my zfs installer script, you will have a /nix
  # too so uncomment this...
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
  #fileSystems."/home/lova/.local/share/atuin" = {
  #  device = "/dev/zvol/NIXROOT/atuin";
  #  fsType = "ext4";
  #};
  networking.hostName = "mainland"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "4dfa8a4e"; # needed for zfs
  swapDevices = [];

  networking.extraHosts = ''
    10.100.0.236 valley
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

  # nix.settings.sandbox = false;

  nix.settings = {
    download-buffer-size = 500000000; # 500 MB
    trusted-users = ["root" "lova" "@wheel" "@trusted"];
    experimental-features = ["flakes" "nix-command"];
    auto-optimise-store = true;
    # allow-import-from-derivation = false;
  };
}
