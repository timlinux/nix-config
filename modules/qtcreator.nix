{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    qtcreator

  ];
}

