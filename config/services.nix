{ pkgs, ... }:

{

  # Example of how to set system wide env vars
  environment.variables = {
    #STARSHIP_CONFIG = "/etc/starship.toml";
  };

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    # After unstalling do
    # systemctl --user enable syncthing
    # See also https://discourse.nixos.org/t/syncthing-systemd-user-service/11199
    syncthing
  }
}

