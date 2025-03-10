{pkgs, ...}: {
  nixpkgs.overlays = [(import ../../packages)];
   environment.systemPackages = with pkgs; [
    micromamba-shell
  ];
  environment.variables = {
    MAMBA_ROOT_PREFIX = "$HOME/micromamba";
  };
  }
