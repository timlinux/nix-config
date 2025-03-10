{ config, pkgs, ... }: 
let
	micromamba-shell = pkgs.callPackage ../../packages/micromamba-shell/default.nix { };
in
{
   environment.systemPackages = with pkgs; [
    micromamba-shell
  ];
  environment.variables = {
    MAMBA_ROOT_PREFIX = "$HOME/micromamba";
  };
  }
