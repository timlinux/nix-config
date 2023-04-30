{ config, pkgs, ... }:
{

  virtualisation.docker.enable = true;
  users.users.timlinux.extraGroups = [ "docker" ];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 50;
}

