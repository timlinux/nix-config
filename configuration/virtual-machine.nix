{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../configuration/desktop-gnome-wayland.nix
  ];

  #Extra bit of magic for vm
  #Check if we can remove this?
  boot.zfs.devNodes = "/dev/disk/by-path";

  services.xserver.videoDrivers = ["qxl"];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    # needed for vm screen resizing, clipboard etc
    spice-vdagent
  ];
}
