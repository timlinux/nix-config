{ config, pkgs, ... }:
{

  services.nginx.enable = true;
  #services.nginx.virtualHosts."entry.qgis.org" = {
  #  addSSL = true;
  #  enableACME = true;
  #  root = "/var/wwww";
  #};
  security.acme = {
    acceptTerms = true;
    defaults.email = "tim@qgis.org";
  };
}
