{ config, pkgs, ... }:
# Config courtesy of https://github.com/TechsupportOnHold/uxplay/blob/main/uxplay.nix
{
  # Note:
  # 
  # You need to pass the -p option so that the allowed ports
  # opened on the firewall below are used by uxplay when it runs
  #
  # We make an alias below for convenient launching

  programs.fish.shellAliases = {
    ux = "uxplay -m -reset 5 -nohold -n Waterfall -nh -p";
    ax-oculus = "scrcpy --crop 1730:974:1934:450 --max-fps 30";
  };
  environment.systemPackages = with pkgs; [
    uxplay
  ];
  # Open network ports
  networking.firewall.allowedTCPPorts = [ 7000 7001 7100 ];
  networking.firewall.allowedUDPPorts = [ 5353 6000 6001 7011 ];
  # Example of doing it for a specific interface
  networking.firewall.interfaces."eth0".allowedTCPPorts = [ 7000 7001 7100 ];
  networking.firewall.interfaces."eth0".allowedUDPPorts = [ 5353 6000 6001 7011 ];
  
  # To enable network-discovery
  # see config/avahi.nix
}
