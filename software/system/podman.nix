{pkgs, ...}: {
  # Note mutually exclusive with the docker service
  environment.systemPackages = with pkgs; [
    podman
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

  # Other configuration settings...

  # Set kernel parameters
  boot.kernelParams = ["unprivileged_userns_clone=1"];

  # Set sysctl settings
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = true;

  # Enable Podman socket for rootless mode
  systemd.user.services.podman = {
    description = "Podman API Socket";
    serviceConfig = {
      ExecStart = "${pkgs.podman}/bin/podman system service --time=0";
      Restart = "always";
      ExecStartPost = "-${pkgs.podman}/bin/podman info";
    };
    wantedBy = ["default.target"];
  };

  # Add Polkit rule to allow users in the wheel group to manage services
  environment.etc."polkit-1/rules.d/10-wheel-group.rules".text = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
}
