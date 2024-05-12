{pkgs, ...}: {
  # Note mutually exclusive with the docker service
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
}
