{ pkgs, config, ... }:
let
	unstable = import
		(builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
		# reuse the current configuration
		{ config = config.nixpkgs.config; };
in
{

  # Add system wide packages
  environment.systemPackages = with pkgs; [
    unstable.keepassxc
  ];
}

