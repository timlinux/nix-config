{ system ? builtins.currentSystem, pkgs, config, ... }:

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
in {

  environment.systemPackages = with pkgs; [
    unstable.vscode
  ];
}

