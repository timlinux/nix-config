{ config, pkgs, ... }:
{
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 21 * * *     root    /root/nix-config/update-system.sh >> /tmp/cron.log"
    ];
  };
}

