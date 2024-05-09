{
  config,
  pkgs,
  ...
}: {
  # See modules/fetches.nix for other fetchers which do not have home-manager configs defined
  home = {
    # You can add more file entries in case you have more configs
    file = {
      "${config.xdg.configHome}/fastfetch/config.jsonc".text = builtins.readFile ./fastfetch.jsonc;
    };
    packages = with pkgs; [
      fastfetch # Modern Unix system info
    ];
  };
}
