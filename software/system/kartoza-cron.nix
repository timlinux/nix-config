{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [(import ../../packages)];
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * * * * root kartoza-cron >> /tmp/cron.log" # Run every hour
    ];
  };

  environment.systemPackages = with pkgs; [
    # taken from packages folder
    kartoza-cron
    skate
    ntfy-sh
  ];
}
