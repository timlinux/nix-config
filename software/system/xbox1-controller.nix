{
  config,
  pkgs,
  ...
}: {

  # Enable the Zen kernel with Xbox One controller support
 # boot.kernelPackages = pkgs.linuxPackages_zen;
  # Add xpad driver to kernel modules
  boot.kernelModules = [ 
    "xpad" 
  ];

  # Add Xboxdrv if desired
  environment.systemPackages = with pkgs; [
    xboxdrv
  ];
  # Configure udev rules
  services.udev.extraRules = ''
    # Xbox controllers
    KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="Microsoft X-Box 360 pad", MODE="0666"
  '';
}
