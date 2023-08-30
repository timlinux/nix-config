#
# Inspired by this repo: https://github.com/pbek/playwright-example
#
{ config, pkgs, ... }:
let
	unstable = import
		(builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/9665f56e3b9c0bfaa07ca88b03b62bb277678a23.tar.gz)
		# reuse the current configuration
		{ config = config.nixpkgs.config; };
in
{
        environment.variables = {
                PLAYWRIGHT_BROWSERS_PATH="${pkgs.playwright-driver.browsers}";
        };
	environment.systemPackages = with pkgs; [
                nodejs
                playwright-test
                python311Packages.playwright
                python311Packages.pytest
	];
}
