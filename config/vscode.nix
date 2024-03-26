{ pkgs, config, ... }:

let
  unstable = import
    (builtins.fetchTarball {
      url="https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
      sha256="085jmvkr1r1ag18mp2skf9nrap3i3gwphlf7zaagwfh9q11lj13l";
    })
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in {

  environment.systemPackages = with pkgs; [
    unstable.vscode
  ];
}

