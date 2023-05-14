{ config, pkgs, ... }:
{
  # You can also run JupyterLab easily - 
  # see https://github.com/tweag/jupyenv
  environment.systemPackages = with pkgs; [
     (python3.withPackages(ps: with ps; [ 
         pandas 
         requests
         pip
         future
     ]))
    ];
}
