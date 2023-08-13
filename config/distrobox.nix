{ pkgs, ... }:

{

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}

