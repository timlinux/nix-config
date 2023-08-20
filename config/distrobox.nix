{ pkgs, ... }:

{

  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}

