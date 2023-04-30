{ config, pkgs, ... }:
{

  virtualisation.docker.enable = true;
  users.users.timlinux.extraGroups = [ "docker" ];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

}

