{ config, pkgs, ... }:
{
  ##
  ## Nvidia related
  ##

  # NVIDIA drivers are unfree.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # My card is the Geforce 1030
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.nvidia.modesetting.enable = true;
  # Fix dispay issues on suspend resume
  hardware.nvidia.powerManagement.enable = true;  

  ##
  ## End of nvidia settings
  ##
}
