{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zesarux # zx spectrum emulator
    sjasmplus # assembly compiler
  ];
}

