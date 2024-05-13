{ config, pkgs,  ... }: 
{
  ### Flatpack support
  ### see https://flatpak.org/setup/NixOS
  xdg.portal.enable = true;
  services.flatpak.enable = true;
}
