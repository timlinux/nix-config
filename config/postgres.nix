{ config, pkgs, ... }:
{

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 15 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE kartoza WITH LOGIN PASSWORD 'kartoza' CREATEDB;
      CREATE DATABASE gis;
      GRANT ALL PRIVILEGES ON DATABASE gis TO kartoza;
    '';
  };
}
