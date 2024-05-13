{ config, pkgs, ... }:
# Config courtesy of https://github.com/TechsupportOnHold/uxplay/blob/main/uxplay.nix
{
  # To enable network-discovery
  services.avahi = {
    enable = true;
    nssmdns = true;  # printing
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
      domain = true;
    };
  };
}

