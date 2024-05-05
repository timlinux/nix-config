{
  config,
  pkgs,
  ...
}: {
  # Add the Xbox controller driver to your system packages
  environment.systemPackages = with pkgs; [
    xboxdrv
  ];

  # Add the Xbox controller udev rule to ensure proper permissions
  systemd = {
    udev = {
      rules = [
        "KERNEL==\"event*\", SUBSYSTEM==\"input\", ATTRS{idVendor}==\"045e\", ATTRS{idProduct}==\"02d1\", MODE=\"660\", GROUP=\"input\""
      ];
    };
  };
}
