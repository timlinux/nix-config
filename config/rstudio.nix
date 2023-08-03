{ pkgs, ... }:

{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    rstudio # Set of integrated tools for the R language
  ];
}

