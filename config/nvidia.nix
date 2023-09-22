{ config, pkgs, ... }:
{
  ##
  ## Nvidia related
  ##

  # NVIDIA drivers are unfree.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Fix dispay issues on suspend resume
    # Enable power management (do not disable this unless you have a reason to).
    # Likely to cause problems on laptops and with screen tearing if disabled.
    powerManagement.enable = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    # Does not work with my GT1030
    #open = true;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # My card is the Geforce 1030
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  ##
  ## End of nvidia settings
  ##
}
