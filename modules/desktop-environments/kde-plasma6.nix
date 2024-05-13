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
  services.xserver.displayManager.sddm.wayland.enable = true;
}
