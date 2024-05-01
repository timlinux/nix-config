{config, ...}: {
  config = {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      # Replace cd with z and add cdi to access zi
      options = [
        "--cmd cd"
      ];
    };
  };
}
