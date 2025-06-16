{
  config,
  pkgs,
  ...
}: let
  # Path to your custom icon
  myCustomIcon = ../../resources/kartoza-start-button.png;

  cosmicOverlay = final: prev: {
    cosmic = prev.cosmic.overrideAttrs (old: {
      # This assumes the cosmic package has an icon attribute or similar.
      # If not, you may need to patch the source or assets directly.
      icon = myCustomIcon;
    });
  };
in {
  imports = [
    ../../configuration/base.nix
    ../system/bluetooth.nix
    ../system/sound.nix
  ];

  nixpkgs.overlays = [cosmicOverlay];

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
}
