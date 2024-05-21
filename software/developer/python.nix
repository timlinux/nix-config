{ config, pkgs, ... }:
{
  # You can also run JupyterLab easily - 
  # see https://github.com/tweag/jupyenv
  environment.systemPackages = with pkgs; [
     python310Packages.weasyprint
     (python3.withPackages(ps: with ps; [ 
         requests
         pip
         # need to pip install mkdocs-with-pdf
     ]))
    ];
}
