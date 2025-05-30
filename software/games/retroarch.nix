{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (retroarch.overrideAttrs (old: {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        fuse
      ];
    }))
  ];
}
