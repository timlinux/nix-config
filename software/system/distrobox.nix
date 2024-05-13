{pkgs, ...}: {
  # Add system wide packages
  # Needs also either podman or docker installed
  # see podman.nix and docker.nix
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
