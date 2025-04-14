{
  config,
  pkgs,
  geospatial-nix,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qgisWithExtras
  ];
}
