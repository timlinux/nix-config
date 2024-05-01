{ config, pkgs, ... }:
# see https://carjorvaz.com/posts/setting-up-headscale-on-nixos/
let 
  domain = "processing.eointelligence.ca";
in {
  services = {
    nginx.virtualHosts.${domain} = {
      addSSL = true;
      enableACME = true;
      #root = "/var/wwww";
      locations."/" = {
        proxyPass =
          "http://localhost:8888";
        proxyWebsockets = true;
      };
    };
  };

  environment.systemPackages = [ ];

}
