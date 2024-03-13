{ config, pkgs, ... }:
# see https://carjorvaz.com/posts/setting-up-headscale-on-nixos/
let 
  domain = "entry.qgis.org";
in {
  services = {
    headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8080;
      settings = { 
        logtail.enabled = false; 
        server_url = "https://${domain}";
        dns_config = { baseDomain = "qgis.org"; };
      };
    };

    nginx.virtualHosts.${domain} = {
      addSSL = true;
      enableACME = true;
      #root = "/var/wwww";
      locations."/" = {
        proxyPass =
          "http://localhost:${toString config.services.headscale.port}";
        proxyWebsockets = true;
      };
    };
  };

  environment.systemPackages = [ config.services.headscale.package ];

}
