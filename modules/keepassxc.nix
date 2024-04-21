# See also this video for setting up HMAC 
# YubiKey based access https://www.youtube.com/watch?v=ATvNK5LKpv8
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
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    unstable.keepassxc
  ];
}

