{pkgs, ...}: {
  # Add system wide packages
  # Needs also either podman or docker installed
  # see podman.nix and docker.nix

  ##
  ## For hints on how to set up python deps with QGIS
  ## see the top level README.md in this repo
  ##
  nixpkgs.overlays = [(import ../../packages)];
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
