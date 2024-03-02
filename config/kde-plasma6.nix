# Install QGIS from the unstable channel
# See https://discourse.nixos.org/t/installing-only-a-single-package-from-unstable/5598/4
 
##
## For hints on how to set up python deps with QGIS
## see the rstudio config
##

{ config, pkgs, ... }:
let
	unstable = import
		(builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
		# reuse the current configuration
		{ config = config.nixpkgs.config; };
in
{
        services.xserver.desktopManager.plasma6.enable = true;
        services.xserver.displayManagers.sddm.wayland.enable = true;
	environment.systemPackages = with pkgs; [
	];
}

