{ pkgs, config, ... }:

let
  unstable = import <nixos-unstable> 
    { config = config.nixpkgs.config; };
in {

  environment.systemPackages = with pkgs; [
    vscode
  ];
}

