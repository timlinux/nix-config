{
  config,
  pkgs,
  ...
}: {
  ##
  ## Nvidia related
  ##
  environment.systemPackages = with pkgs; [
    nvtopPackages.full # nvidia gpu monitor ## XXX Disabled to avoid pulling in cuda which takes ages to build
  ];

  # NVIDIA drivers are unfree.
  hardware.graphics.enable32Bit = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Fix dispay issues on suspend resume
    # Enable power management (do not disable this unless you have a reason to).
    # Likely to cause problems on laptops and with screen tearing if disabled.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    # Does not work with my GT1030
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # We have a GeForce RTX 4060 which is not in the legacy GPU list (https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/)
    # Therefore, the stable drivers should work.
    # Optionally, you may need to select the appropriate driver version for your specific GPU.s
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Please read the docs here: https://nixos.wiki/wiki/Nvidia
    # Our approach is to use prime, register the nvidia card but
    # only use it on an app by app basis
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      # intelBusId = # for intel gpu
      amdgpuBusId = "PCI:07:0:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };

  ##
  ## End of nvidia settings
  ##
}
