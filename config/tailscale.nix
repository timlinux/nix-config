{ config, pkgs, ... }:

{
  # make the tailscale command usable to users
  environment.systemPackages = [ pkgs.tailscale ];

  # enable the tailscale service
  services.tailscale.enable = true;


  # Optional (default: 41641):
  services.tailscale.port = 41641;

  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.checkReversePath = "loose";

  # Now configure from the command line like this:
  # systemctl status tailscale

  # Finally, perform an initial authentication for this machine and you’re done.
  # sudo tailscale login
  # sudo tailscale up

  # Validate:
  # ip link show tailscale0
  # journalctl -fu tailscale

}

