{  system ? builtins.currentSystem, pkgs, config, ... }:
let
	unstable = import
		(builtins.fetchTarball {
                   url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
                   sha256="sha256:085jmvkr1r1ag18mp2skf9nrap3i3gwphlf7zaagwfh9q11lj13l";
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

