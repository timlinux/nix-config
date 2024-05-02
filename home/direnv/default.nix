{
  config = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    home.sessionVariables = {
      #Disable spammy messages when direnv loads
      DIRENV_LOG_FORMAT = "";
    };
  };
}
