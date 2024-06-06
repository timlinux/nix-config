{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [(import ../../packages)];
  boot.loader.grub.theme = pkgs.kartoza-grub;
  # This is for the intermediate screen
  # between choosing a boot option and when
  # plymouth starts
  # See https://discourse.nixos.org/t/how-to-use-boot-loader-grub-splashimage/23748
  boot.loader.grub.splashImage = ../../resources/kartoza-background.gdm.png;
}
