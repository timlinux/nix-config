# Install kde plasma - currently you need to be on unstable to do it
# See https://discourse.nixos.org/t/enable-plasma-6/40541
{  system ? builtins.currentSystem, pkgs, config, ... }:
let
	unstable = import
		(builtins.fetchTarball {
                   url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
                   sha256="1nzkvhf90fh7mqy10dv6rdb76yl1a6xy3icsndmz1a7b1zbllsci";
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

