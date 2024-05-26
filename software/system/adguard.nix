# Note I needed to restart my computer after setting this up
{
  config,
  pkgs,
  ...
}: let
  adguardPort = 3000;
in {
  config = {
    networking = {
      nameservers = ["127.0.0.1" "::1"];
      # If using dhcpcd:
      dhcpcd.extraConfig = "nohook resolv.conf";
      # If using NetworkManager:
      networkmanager.dns = "none";
      firewall = {
        allowedTCPPorts = [adguardPort];
        allowedUDPPorts = [53];
      };
    };

    services = {
      adguardhome = {
        enable = true;
        mutableSettings = true;
        allowDHCP = false;
        openFirewall = false;
        settings = {
          bind_port = adguardPort;
          #schema_version = 20;
        };
      };
    };
  };
}
