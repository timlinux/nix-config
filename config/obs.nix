{ config, pkgs, ... }:
{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    obs-studio
  ];
  ### OBS Virtual Camera Support
  ### See also OBS packages installed further up
  boot.extraModulePackages = [
     config.boot.kernelPackages.v4l2loopback
  ];  
}
