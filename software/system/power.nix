{pkgs, ...}: {
  # Enable power management - only usefule
  # if you have a laptop or a device that needs
  # power management
  services.upower = {
    enable = true;
    percentageLow = 10;
    percentageCritical = 7;
    percentageAction = 5;
  };
}
