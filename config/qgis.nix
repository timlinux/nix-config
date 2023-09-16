# Install QGIS from the unstable channel
# See https://discourse.nixos.org/t/installing-only-a-single-package-from-unstable/5598/4
 
{ config, pkgs, ... }:
let
	unstable = import
		(builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
		# reuse the current configuration
		{ config = config.nixpkgs.config; };
in
{
	environment.systemPackages = with pkgs; [
		#qgis # Installed from stable
		#unstable.qgis-ltr # Installed from unstable
		unstable.qgis # Installed from unstable
                saga
	];
}

