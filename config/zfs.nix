{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pv # needed for backups
    sanoid
  ];
}
