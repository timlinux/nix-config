{ config, pkgs, ... }:
{

  ### Fingerprint reader support
  ### See https://discourse.nixos.org/t/how-to-use-fingerprint-unlocking-how-to-set-up-fprintd-english/21901
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  # Works for thinkpad p14s
  #services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; 
  # If the vfs0090 Driver does not work, use the following driver
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

}
