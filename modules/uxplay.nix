{ system ? builtins.currentSystem, config, pkgs, ... }:
# Config courtesy of https://github.com/TechsupportOnHold/uxplay/blob/main/uxplay.nix
let
  # For packages pinned to a specific version
  pinnedHash = "c2786e7084cbad90b4f9472d5b5e35ecb57958af"; 
  pinnedPkgs = import (fetchTarball {
     url="https://github.com/NixOS/nixpkgs/archive/${pinnedHash}.tar.gz";
     sha256="1g8wq4bfq9y1h2qch8nac31sas3lgrbxra7lcc5hj9jgyrzjsm3y";
  });
in 
{
  # Note:
  # 
  # You need to pass the -p option so that the allowed ports
  # opened on the firewall below are used by uxplay when it runs
  #
  # We make an alias below for convenient launching

  programs.fish.shellAliases = {
    ux = "uxplay -m -reset 5 -nohold -n Nixos -nh -p";
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
