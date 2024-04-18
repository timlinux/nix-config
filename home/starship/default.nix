{
  pkgs,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../../dotfile/starship.toml;
  };
}
