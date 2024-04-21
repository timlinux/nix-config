{ config, pkgs, ... }:

{

  # Support for hp officejet
  # In users, make sure to add them to the scanner group too
  # users.users.<username>.extraGroups = [ ... "scanner" ];
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
}
