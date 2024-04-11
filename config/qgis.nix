# Install QGIS from the unstable channel
# See https://discourse.nixos.org/t/installing-only-a-single-package-from-unstable/5598/4
 
##
## For hints on how to set up python deps with QGIS
## see the rstudio config
##

{ system ? builtins.currentSystem, config, pkgs, ... }:
let
	unstable = import
		(builtins.fetchTarball {
                    url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
                    sha256="0xsl3dsqx1i717waihk29nk3jqkrk5jcw9hxsbw97p5dbbnc47li";
                })
		# reuse the current configuration
		{ 
                   inherit system;
                   config = config.nixpkgs.config; };
in
{
        nixpkgs.config.permittedInsecurePackages = [
                "qtwebkit-5.212.0-alpha4"
        ];
	environment.systemPackages = with pkgs; [
		#qgis # Installed from stable
		#unstable.qgis-ltr # Installed from unstable
		unstable.qgis # Installed from unstable
                python311Packages.pyqt5_with_qtwebkit
		libsForQt5.qt5.qtwebkit
                saga
	];
}

