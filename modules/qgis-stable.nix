{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		qgis # Installed from stable
	];
}

