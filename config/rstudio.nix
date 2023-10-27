{ pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    rstudio # Set of integrated tools for the R language
    libxml2 # needed for tidyverse
    fontconfig
    zlib
  ];
}

