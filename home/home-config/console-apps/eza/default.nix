{config, ...}: {
  config = {
    programs.eza = {
      enable = true;
      icons = "auto";
      #conflicts with fish config
      #enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
    };
  };
}
