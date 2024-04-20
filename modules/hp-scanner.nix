{ pkgs, ... }:

{
  # see https://discourse.nixos.org/t/scanning-with-hp-scanner/23415 
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  
  # To enable network-discovery
  # see config/avahi.nix

  # Add system wide packages
  environment.systemPackages = with pkgs; [
  ];
}

