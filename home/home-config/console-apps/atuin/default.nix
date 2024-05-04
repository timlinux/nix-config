{
  config,
  pkgs,
  ...
}: {
  config = {
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      flags = [
        #"--disable-up-arrow"
      ];
      package = pkgs.atuin;
      settings = {
        auto_sync = false;
        enter_accept = true; #immediately execute if enter pressed - use tab to edit first
        #dialect = "uk";
        #key_path = config.sops.secrets.atuin_key.path;
        show_preview = true;
        style = "full";
        #sync_frequency = "1h";
        #sync_address = "https://api.atuin.sh";
        update_check = false;
      };
    };
  };
}
