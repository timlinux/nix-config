{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # A virtual machine used for testing and development.
  # Create the machine in virtman with
  # 8GB ram
  # 8 cores
  # 200GB disk
  # UEFI Boot

  imports = [
    ../configuration/desktop-gnome-x11.nix
    ../configuration/desktop-apps.nix
    ../modules/locale-za-en.nix
    ../modules/locale-pt-en.nix
    ../modules/zfs-encryption.nix
    ../users/guest.nix
    ../users/tim.nix
  ];

  #Extra bit of magic for vm
  #Check if we can remove this?
  boot.zfs.devNodes = "/dev/disk/by-path";

  # Needed for vm screen resizing, clipboard etc
  # -----------------------------------

  services.xserver.videoDrivers = ["qxl"];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];
  # -----------------------------------

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "NIXROOT/root";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "NIXROOT/nix";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/vda1";
    #use uuid rather
    #device = "/dev/disk/by-uuid/D7EC-2233";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "NIXROOT/home";
    fsType = "zfs";
  };

  networking.hostName = "rock"; # Define your hostname.
  # See https://search.nixos.org/options?channel=unstable&show=networking.hostId&query=networking.hostId
  # Generate using this:
  # head -c 8 /etc/machine-id
  networking.hostId = "0c83c5df"; # needed for zfs
  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
