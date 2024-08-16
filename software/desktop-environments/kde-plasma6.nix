# Install kde plasma - currently you need to be on unstable to do it
# See https://discourse.nixos.org/t/enable-plasma-6/40541
{
  system ? builtins.currentSystem,
  pkgs,
  config,
  ...
}: {
  # Unstable defined in flake.nix and overlaid to be available here
  services.desktopManager.plasma6.enable = true;
  #services.xserver.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  environment.etc."kartoza-wallpaper.png" = {
    mode = "0555";
    source = ../../resources/kartoza-wallpaper.png;
  };
  services.displayManager.sddm.settings = {
    Theme = {
      Background = "/etc/kartoza-wallpaper.png";
    };
  };
}
