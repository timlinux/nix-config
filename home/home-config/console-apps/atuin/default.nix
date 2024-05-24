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
        networkAccess = false;
        #immediately execute if enter pressed - use tab to edit first
        enter_accept = true;
        show_preview = true;
        style = "full";
        update_check = false;
        sync_frequency = false; # Set sync_frequency to null to disable syncing
        sync_address = false; # Set sync_address to null to disable syncing
      };
    };
  };
}
