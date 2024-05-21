{config, ...}: {
  config = {
    programs.eza = {
      enable = true;
      #conflicts with fish config
      #enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
      icons = true;
    };
  };
}
