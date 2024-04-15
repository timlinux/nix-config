{ config,pkgs,...}: 
{
  # See vm-test-environment.sh in top of nix-config repo
  # See https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
  virtualisation.vmVariant = {
    # following configuration is added only when building nixos with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 4;
    };
  };

  imports = [
    ./configuration-base.nix
    ../users/all.nix
    ../users/tim.nix
    ../users/guest.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  networking.hostName = "test"; # Define your hostname.
}
