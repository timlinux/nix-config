{ config, pkgs, ... }:

##
## Use this to deploy anything that you want the bleeding edge version of
##
 
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable)
    { config = config.nixpkgs.config; };
in {
  environment.systemPackages = with pkgs; [
     ## List of unstable packages goes here
  ];
}
