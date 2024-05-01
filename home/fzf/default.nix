{config, ...}: {
  config = {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
