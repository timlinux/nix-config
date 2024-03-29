{ config, pkgs, ... }:
{
  let adguardPort = 3000;
  in {
    config = {
      networking = {
        firewall = {
          allowedTCPPorts = [ adguardPort ];
          allowedUDPPorts = [ 53 ];
        };
      };
  
      services = {
        adguardhome = {
          enable = true;
          openFirewall = true;
          settings = {
            bind_port = adguardPort;
            schema_version = 20;
          };
        };
      };
    };
  }
}
