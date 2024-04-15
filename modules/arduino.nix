{ pkgs, ... }:

{
  environment.interactiveShellInit = ''
  '';

  environment.systemPackages = with pkgs; [
    fritzing
    arduino
    arduino-cli
  ];
}

