{ pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    nodejs_20 
  ];
}

