{pkgs, ...}: {
  # Enable power management - only useful
  # if you have a laptop or a device that needs
  # power management
  services.upower = {
    enable = true;
    percentageLow = 10;
    percentageCritical = 7;
    percentageAction = 5;
  };
  # Make the device suspend when the power button is pressed
  services.logind = {
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };
}
