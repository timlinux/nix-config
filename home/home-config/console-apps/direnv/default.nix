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
      #Set any env vars here
      #Disable spammy messages when direnv loads
      DIRENV_LOG_FORMAT = "";
    };
  };
}
