{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    warzone2100
    minetest
  ];
}

