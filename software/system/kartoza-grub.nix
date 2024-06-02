{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [(import ../../packages)];
  boot.loader.grub.theme = pkgs.kartoza-grub;
}
