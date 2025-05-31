{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../configuration/base.nix
    ../system/bluetooth.nix
    ../system/sound.nix
  ];
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
}
