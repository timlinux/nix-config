{ pkgs, ... }:

{
  # pycharm-community edition
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-community
  ];
}
