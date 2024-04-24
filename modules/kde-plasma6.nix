# Install kde plasma - currently you need to be on unstable to do it
# See https://discourse.nixos.org/t/enable-plasma-6/40541
{  system ? builtins.currentSystem, pkgs, config, ... }:
let
	unstable = import
		(builtins.fetchTarball {
                   url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
                   sha256="1g8wq4bfq9y1h2qch8nac31sas3lgrbxra7lcc5hj9jgyrzjsm3y";
                })
		# reuse the current configuration
		{ 
                   inherit system;
                   config = config.nixpkgs.config; };
in
{
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;  
}

