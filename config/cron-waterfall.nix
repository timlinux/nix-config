{ config, pkgs, ... }:
{
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      root    date >> /tmp/cron.log"
    ];
  };
}

