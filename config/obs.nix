{ config, pkgs, ... }:
{
  # Add system wide packages
  environment.systemPackages = with pkgs; [
    obs-studio
    obs-studio-plugins.wlrobs # wayland capture support
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-move-transition # Plugin for OBS Studio to move source to a new position during scene transition
    obs-studio-plugins.obs-backgroundremoval # OBS plugin to replace the background in portrait images and video
  ];
  ### OBS Virtual Camera Support
  ### See also OBS packages installed further up
  boot.extraModulePackages = [
     config.boot.kernelPackages.v4l2loopback
  ];  
}
